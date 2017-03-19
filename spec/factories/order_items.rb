FactoryGirl.define do
  factory :order_item do
    qty 1
    price 10.00
    book
    order
  end
end