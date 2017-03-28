class Address < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :country
end
