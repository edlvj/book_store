require 'rails_helper'

RSpec.describe Book, :category, :type => :model do
  subject(:category) { create :category }
  
  context 'association' do
    it { should have_many :books }
  end
  
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
end  