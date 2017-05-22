require 'rails_helper'
include Support::Forms

RSpec.feature 'Payment step', type: :feature do
  let(:user) { create :user }
  let(:order) { create :order, :checkout_package, user: user }
  let(:credit_card) { create :credit_card }

  background do
    @shipping = create :shipping
    @credit_card_form = CreditCard.new
    allow_any_instance_of(CheckoutController)
      .to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
  end

  scenario "When user don't choose delivery" do
    order.shipping = nil
    visit checkout_path(id: :payment)
    expect(current_path).to eq(carts_path)
    expect(page).to have_content(I18n.t('flash.failure.step'))
  end

  scenario "When user fill credit_card" do
    order.update_attribute(:shipping_id, @shipping.id)
    visit checkout_path(id: :payment)
    fill_payment_form("edit_order_#{order.id}", credit_card)
    expect(current_path).to eq(checkout_path(id: :confirm))
  end
end