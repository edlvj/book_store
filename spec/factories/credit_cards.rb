FactoryGirl.define do
  factory :credit_card do
    name 'Taras Shevchenko'
    number '204343434343434'
    expiration_date '12/96'
    cvv '123'
    
    trait :invalid do
      name nil
      number nil
    end
  end
end