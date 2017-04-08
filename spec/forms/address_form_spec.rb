require 'rails_helper'

RSpec.describe AddressForm, :address_form do
  subject { AddressForm.new(attributes_for(:type_address, :shipping)) }
  
  context 'validation' do
    %i(firstname lastname address zipcode phone city country_id).each do |attribute_name|
      it { should validate_presence_of(attribute_name) }
    end
  end   
  
  %i(firstname lastname city).each do |attribute_name|
    it { should validate_length_of(attribute_name).is_at_most(50) }
  end
  
  it { should validate_length_of(:zipcode).is_at_most(10) }
    
  context 'phone' do
    it { should validate_length_of(:phone).is_at_least(9) }
    it { should validate_length_of(:phone).is_at_most(15) }
    
    it 'format' do
      subject.phone = '+380AAAAA42342'
      is_expected.not_to be_valid
    end
  end    
end  