require 'rails_helper'

describe Author, type: :model do
  subject { build :author }
  
  context 'associations' do
    it { should have_and_belong_to_many(:books) }
  end
 
  context 'validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end  
end  