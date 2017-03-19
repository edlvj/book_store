class Shipping < ApplicationRecord
  has_many :orders
  
  validates :company, presence: true
end
