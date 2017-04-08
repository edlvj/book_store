FactoryGirl.define do
  factory :review do
    title 'Review'
    comment 'My review'
    rating 4
  
    trait :invalid do
      title nil
      comment nil
    end
  end
end