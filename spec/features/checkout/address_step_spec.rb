require 'features/features_spec_helper'
include Support::Forms

feature 'Address step', type: :feature do
  let(:user) { create :user }
  let(:billing) { create :type_address, :billing, user: user }
  let(:order) { create :order, :with_items, user: user }
  let(:billing_attrs) { attributes_for :type_address, :billing }

  background do
    @shipping = create :shipping
    allow_any_instance_of(CheckoutController)
      .to receive(:current_order).and_return(order)
    login_as(user, scope: :user)
  end

  scenario 'When user have billing address' do
    visit checkout_path(id: :address)
    fill_address_form('billing_address', billing_attrs, true)
    expect(current_path).to eq checkout_path(id: :delivery)
  end
end  