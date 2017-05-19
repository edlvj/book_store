class Order < ApplicationRecord
  include CurrentOrder
  include AASM
  
  belongs_to :user
  belongs_to :shipping
  
  has_many :order_items, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_one :coupon, dependent: :nullify
  
  has_one :order_shipping,
          -> { where addressable_type: 'shipping_address' },
          class_name: Address, foreign_key: :order_id,
          dependent: :destroy
  
  has_one :order_billing,
          -> { where addressable_type: 'billing_address' },
          class_name: Address, foreign_key: :order_id,
          dependent: :destroy
  
  accepts_nested_attributes_for :order_items, allow_destroy: true
  accepts_nested_attributes_for :credit_card
  accepts_nested_attributes_for :order_shipping
  accepts_nested_attributes_for :order_billing
  
  aasm do
    state :in_progress, :initial => true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :queued do
      transitions :from => :in_progress, :to => :in_queue
    end
    
    event :to_deliver do
      transitions :from => :in_queue, :to => :in_delivery
    end
    
    event :end_deliver do
      transitions :from => :in_delivery, :to => :delivered
    end 
    
    event :cancel do
      transitions from: [:in_progress, :to_delivery, :end_delivery], to: :canceled
    end
  end
  
  def self.aasm_states
    aasm.states.map(&:name)
  end
end
