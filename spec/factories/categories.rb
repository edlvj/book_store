FactoryGirl.define do
  factory :category do
    id 1
    name { FFaker::Book.genre }
  end
end