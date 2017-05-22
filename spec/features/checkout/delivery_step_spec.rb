require 'rails_helper'

feature 'Delivery step', type: :feature do
  let(:user) { create :user }
  let(:order) { create :order, :checkout_package, user: user }

  background do
    @shipping = create :shipping
    allow_any_instance_of(CheckoutController)
      .to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
  end
  
  scenario "When user fill delivery" do
    visit checkout_path(id: :delivery)
    expect(page).to have_content(@shipping.company)
    first("#shipping_id_#{@shipping.id}", visible: false).set(true)
    click_button I18n.t('checkout.save_and_continue')
    expect(current_path).to eq(checkout_path(id: :payment))
  end
  
  scenario "When user don't choose address" do
    order.shipping = nil
    order.order_shipping = nil
    order.order_billing = nil
    visit checkout_path(id: :delivery)
    expect(current_path).to eq(carts_path)
    expect(page).to have_content(I18n.t('flash.failure.step'))
  end
end  