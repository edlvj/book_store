FactoryGirl.define do
  factory :admin_user do
    password 'password'
    password_confirmation 'password'
    email "admin@gotdam.domain"
  end
end