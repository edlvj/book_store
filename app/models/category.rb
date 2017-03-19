class Category < ApplicationRecord
  has_many :books
  
  DEFAULT = 'Mobile development'
end
