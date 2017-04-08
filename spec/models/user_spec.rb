require 'rails_helper'

describe User, type: :model do
  subject { build :user }
  
  context 'associations' do
    %i(reviews orders credit_cards).each do |model_name|
      it { should have_many(model_name) }
    end
    
    %i(address user_shipping user_billing).each do |model_name|
      it { should have_one(model_name) }
    end
  end
  
  context 'validation' do
    it { should validate_length_of(:firstname).is_at_most(50) }
    it { should validate_length_of(:lastname).is_at_most(50) }
    it { should validate_length_of(:email).is_at_most(63) }
  end
end  