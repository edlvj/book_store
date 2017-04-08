FactoryGirl.define do
  factory :credit_card do
    name 'Taras Shevchenko'
    number '204343434343434'
    expiration_date '19/33'
    cvv '123'
    order_id { create(:order).id }
    user_id { create(:user).id }
  end
end