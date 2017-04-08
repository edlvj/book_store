class Shipping < ApplicationRecord
  has_many :orders
  
  validates :company, :costs, :days, presence: true
  validates :costs, :days, numericality: { greater_than: 0 }
end
