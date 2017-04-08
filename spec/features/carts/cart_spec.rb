require 'features/features_spec_helper'

feature 'User on cart', type: :feature do
  let(:user) { create :user }
  let(:order_empty) { create :order, user: user }
  let(:order_with_items) { create :order, :with_items, user: user }
  let(:item) { order_with_items.order_items.first }
  
  scenario 'When user have order items' do
    allow_any_instance_of(CartsController).to receive(:current_order)
      .and_return(order_with_items)
    visit carts_path
    expect(page).to have_content(I18n.t('cart.cart'))
    expect(page).to have_no_content(I18n.t('cart.no_items'))
    expect(page).to have_content(item.book.title)
    expect(page).to have_content(item.qty)
    expect(page).to have_content(order_with_items.sub_total
  end
  
  scenario 'When user have empty cart' do
    allow_any_instance_of(CartsController).to receive(:current_order)
      .and_return(order_empty)
    visit carts_path
    expect(page).to have_content(I18n.t('cart.no_items'))
    expect(page).not_to have_content(I18n.t('cart.update_cart'))
  end
end  