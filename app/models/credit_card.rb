class CreditCard < ApplicationRecord
  belongs_to :user
  belongs_to :order
  
  validates :number, :cvv, :expiration_date, presence: true
 # validates :number, :cvv, :expiration_date, numericality: true
 # validates :number, :length => { :is => 16 }
 # validates :expiration_date, format: { with: /^(0[1-9]|1[0-2])\/\d{2}$\z/, message: 'Invalid date format', :multiline => true }
end
