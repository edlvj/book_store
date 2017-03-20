class User < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  has_many :reviews
  has_many :orders, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
  has_one :address
  
  has_one :user_shipping,
          -> { where type: 'shipping_address' },
          class_name: Address, foreign_key: :user_id,
          dependent: :destroy
          
   has_one :user_billing,
          -> { where type: 'billing_address' },
          class_name: Address, foreign_key: :order_id,
          dependent: :destroy
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name  
      user.image = auth.info.image 
    end
  end
  
  def order_in_processing
    @order_in_processing ||= orders.where(aasm_state: :in_progress).last || orders.create
  end
  
  def queue_order
    @last_order ||= orders.in_queue.last
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
