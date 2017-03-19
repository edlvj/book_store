class Order < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :shipping
  
  has_many :order_items, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_one :coupon, dependent: :nullify
  
  has_one :order_shipping,
          -> { where type: 'shipping_address' },
          class_name: Address, foreign_key: :order_id,
          dependent: :destroy
  
  has_one :order_billing,
          -> { where type: 'billing_address' },
          class_name: Address, foreign_key: :order_id,
          dependent: :destroy
  
  accepts_nested_attributes_for :order_items, allow_destroy: true

  aasm do
    state :in_progress, :initial => true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :queued do
      transitions :from => :in_progress, :to => :in_queue
    end
  end
  
  def self.assm_states
    aasm.states.map(&:name)
  end
  
  def add_order_item(book_id, quantity = 1)
    item = order_items.find_by(book_id: book_id)
    if item
      item.increment :qty, quantity
    else
      order_items.new(qty: quantity, book_id: book_id)
    end
  end
  
  def merge_order!(order)
    return self if self == order
    order.order_items.each do |order_item|
      add_order_item(order_item.book_id, order_item.qty).save
    end
    self.coupon = nil if order.coupon.present?
    order.destroy && order.coupon&.update_attributes(order: self)
    tap(&:save)
  end
  
  def items_count
    order_items.map(&:qty).sum
  end
  
  def sub_total
    order_items.map(&:sub_total).sum
  end
  
  def coupon_total
    coupon ? sub_total * (coupon.discount / 100.0) : 0.00
  end
  
  def shipping_total
    shipping ? shipping.costs : 0.00
  end  
  
  def total_cost
    sub_total - coupon_total + shipping_total
  end
end
