FactoryGirl.define do
  factory :order do
    user
    
    trait :with_items do
      order_items { create_list(:order_item, 2) }
    end
    
    trait :checkout_package do
      order_items { create_list(:order_item, 2) }
      order_shipping { create :address_order, :shipping }
      order_billing { create :address_order, :billing }
      coupon
      credit_card
    end

    factory :order_with_book do
      transient do
        qty 1
        book_id rand(2..20)
        category_id 1
      end

      after :create do |order, evaluator|
        create :order_item,
          book: create(:book, id: evaluator.book_id),
          qty: evaluator.qty,
          order: order
      end
    end
  end
end