require 'rails_helper'

describe Shipping, type: :model do
  subject { build :shipping }
  
  context 'association' do
    it { should have_many :orders }
  end
  
  context 'validation' do
    %i(company costs days).each do |field_name|
      it { should validate_presence_of(field_name) }
    end

    it { should validate_numericality_of(:costs).is_greater_than(0) }
    it { should validate_numericality_of(:days).is_greater_than(0) }
  end      
end