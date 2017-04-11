FactoryGirl.define do
  factory :address do
    firstname 'test'
    lastname 'tests'
    address FFaker::Address.street_name
    city 'New York'
    zipcode 49_000
    phone '+380632863823'
    country_id { create(:country).id }
    user
  end
  
  factory :type_address, parent: :address do
    
    trait :shipping do
      addressable_type :shipping_address
    end

    trait :billing do
      addressable_type :billing_address
    end
  end
  
  factory :address_order, parent: :type_address do
  end
end  