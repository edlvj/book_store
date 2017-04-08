FactoryGirl.define do
  factory :coupon do
    code 'ruby'
    discount 20
  end
  
  trait :used do
    order
  end
end