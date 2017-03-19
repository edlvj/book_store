FactoryGirl.define do
  factory :user do
    name { FFaker::Name.first_name }
    password 'password'
    password_confirmation 'password'
    sequence(:email) { |n| "email-#{n}@some.domain" }
  end
end