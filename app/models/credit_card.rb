class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :order, dependent: :destroy
end
