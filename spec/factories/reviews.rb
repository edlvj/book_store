FactoryGirl.define do
  factory :review do
    title 'Review'
    comment 'My review'
    rating 4
    user_id { create(:user).id }
    book_id { create(:book).id }

    trait :invalid do
      title nil
      comment nil
    end
  end
end