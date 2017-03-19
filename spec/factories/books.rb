FactoryGirl.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price 14.00
    category
    
    trait :invalid do
      title nil
    end

  end
end