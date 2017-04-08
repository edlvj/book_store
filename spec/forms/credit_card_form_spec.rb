require 'rails_helper'

RSpec.describe CreditCardForm, :address_form do
  subject { CreditCardForm.new(attributes_for(:credit_card)) }
  
  %i(name number cvv expiration_date).each do |attribute_name|
    it { should validate_presence_of(attribute_name) }
  end
  
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
  it { should validate_length_of(:expiration_date).is_at_most(5) }
end