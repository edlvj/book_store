class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  
  validates :qty, :book_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  def sub_total
    @sub_total ||= qty * book.price
  end
end
