class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  
  validates :qty, presence: true
  
  def sub_total
    @sub_total ||= qty * book.price
  end
end
