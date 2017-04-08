class Book < ApplicationRecord
  paginates_per 12
 
  has_and_belongs_to_many :author
  belongs_to :category
  has_many :reviews
  has_many :order_items
  
  validates :title, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  mount_uploader :image, BookImageUploader
end
