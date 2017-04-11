require 'ffaker'

USERS_AMOUNT  = 5
AUTHORS_AMOUNT = 10
BOOK_PRICE_RANGE = 2.00..50.00
BOOK_AMOUNT_IN_ORDER_ITEM = 1..3
BOOKS_IN_CATEGORY_RANGE = 15..25
AUTHORS_FOR_ONE_BOOK = 1..3
ORDERS_AMOUNT_RANGE = 0..2
ORDER_ITEMS_AMOUNT_RANGE = 1..3

BOOK_IMAGES = ['https://lh6.googleusercontent.com/s624Am4SwpbuUr2PoLqo7O9d4LB0qNlVK2Mt4YAOAnzLz4xQk5H3WMoTKN6igKtT1y2xihDARWjn2xo=w1920-h934-rw',
               'https://lh3.googleusercontent.com/V_T0wlerwtXOqKqWb4O-AH_hTBRGBVvAC0s94evyv4pExaTc7A3QGbqYsj_1Nzi7AlCpMNnIzuhp1jY=w1920-h934-rw',
               'https://lh4.googleusercontent.com/UcGPsoy4YP0a_9sgI-R8yM8A8A_bLvLoTr5RpEKMeymdL9H9OzwcLlMpfbb5e4dxZgmvZVgKbilm26w=w1920-h934-rw',
               'https://lh4.googleusercontent.com/upwLh_DdSu1l2pWyH9IroSOiyWE7EzglwWhX1mTVst6-L7lE7jErS2of6EdzuSDUUk2d5ZCM9DjXsIc=w1920-h934',
               'https://lh3.googleusercontent.com/2i7T9nIp3N1dm7-Z7nd5MCFJsClXDKt91eoUP898qsMjwOXnG54yc3xMUNfk4U3Jrl0-QQKkLZrL8mY=w1920-h934',
               'https://lh6.googleusercontent.com/neQBswK9tZirQfluJL0aSbCkYrXccorFkOgjJwlT6SkCPZ9UJUtL8OeC6aQvDm3w9KE2xYMI6kBJ_-I=w1920-h934-rw',
               'https://lh4.googleusercontent.com/JFeUJCz7hG0Cy56Z-k2BGzzuUkJzuBvCcXQbKCJlN8-GxQ4L0X2bXE9Wo4GFSyExpvx4p16iXeCBhx4=w1920-h934']

ORDER_STATES = [:processing,
                :in_delivery,
                :delivered,
                :canceled]
                
AdminUser.create!(email: 'admin@example.com', 
                  password: '111111', 
                  password_confirmation: '111111')
            
USERS_AMOUNT.times do
  User.create! email: "#{rand(1..20)}_#{FFaker::Internet.free_email}",
                  firstname: FFaker::Name.first_name,
                  lastname: FFaker::Name.last_name,
                  password: 'password',
                  password_confirmation: 'password'
end
                  

AUTHORS_AMOUNT.times do
  Author.find_or_create_by! first_name: FFaker::Name.name,
                            last_name: FFaker::Name.name,
                            description: FFaker::CheesyLingo.paragraph
end

['Mobile development', 'Photo', 'Web design', 'Web Development'].each do |type|
  Category.find_or_create_by! name: type
end

Category.find_each do |category|
  rand(BOOKS_IN_CATEGORY_RANGE).times do
    Book.find_or_create_by! title: FFaker::CheesyLingo.title,
                            price: rand(BOOK_PRICE_RANGE).round(2),
                            description: FFaker::HealthcareIpsum.paragraph,
                            image: BOOK_IMAGES.sample,
                            category_id: category.id,
                            pub_year: rand(1990..Date.today.year),
                            dimension: 'H:7.0 x W:4.4 x D:10.0'
  end
end

Book.find_each do |book|
  rand(AUTHORS_FOR_ONE_BOOK).times do
    book.author << Author.find_by(id: rand(1..AUTHORS_AMOUNT))
  end
end

User.find_each do |user|
  card = CreditCard.create!(number: 5105105105105100,
                            cvv: 111,
                            expiration_date: "#{Time.now.year}/#{Time.now.month}",
                            name: user.firstname)
  user.credit_cards << card                          
end

User.find_each do |user|
  rand(ORDERS_AMOUNT_RANGE).times do
    order = Order.create credit_card: user.credit_cards.first, shipping_id: rand(1..3)
    rand(ORDER_ITEMS_AMOUNT_RANGE).times do
      item = OrderItem.create(qty: rand(BOOK_AMOUNT_IN_ORDER_ITEM),
                              book_id: rand(1..Book.all.count))
      order.order_items << item
    end
    order.update aasm_state: ORDER_STATES.sample
    user.orders << order
  end
end

Country.create name: "Ukraine"
Country.create name: "USA"

Shipping.create company: 'Delivery Next Day', costs: 5.00, days: 7
Shipping.create company: 'Ali Express', costs: 10.00, days:6
Shipping.create company: 'Nova Poshta', costs: 15.00, days: 7

Coupon.create code: 'ruby', discount: 20
Coupon.create code: 'php', discount: 10
Coupon.create code: 'python', discount: 15 
Coupon.create code: 'go', discount: 5
Coupon.create code: 'elixir', discount: 5