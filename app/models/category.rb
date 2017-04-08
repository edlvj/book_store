class Category < ApplicationRecord
  DEFAULT = 'Mobile development'
  has_many :books

  validates :name, presence: true, length: { maximum: 50 }
end
