class Coupon < ApplicationRecord
  belongs_to :order, optional: true
  
  def active?
    order.blank?
  end
end
