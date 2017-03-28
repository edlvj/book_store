class Book < ApplicationRecord
  paginates_per 12
 
  has_and_belongs_to_many :author
  belongs_to :category
  has_many :reviews
  has_many :order_items
  
  mount_uploader :image, BookImageUploader
end
