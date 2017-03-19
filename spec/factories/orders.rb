FactoryGirl.define do
  factory :order do
    user
   # association :order_shipping, factory: :address
 #   association :order_billing, factory: :address

    factory :order_with_book do
      transient do
        qty 1
        book_id 1
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