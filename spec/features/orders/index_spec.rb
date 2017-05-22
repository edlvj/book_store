require 'rails_helper'

feature 'Index orders', type: :feature do
  let(:user) { create :user }
  let(:order) { create(:order, :with_items, aasm_state: :delivered, user: user) }

  background do
    login_as(user, scope: :user)
  end

  scenario 'User have state list' do
    visit orders_path
    expect(page).to have_content(I18n.t("orders.#{order.aasm_state}"))
  end
end  