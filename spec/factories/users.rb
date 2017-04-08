FactoryGirl.define do
  factory :user do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    password 'password'
    password_confirmation 'password'
    sequence(:email) { |n| "email-#{n}@some.domain" }
  end
end