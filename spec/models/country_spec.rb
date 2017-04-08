require 'rails_helper'

RSpec.describe Country, :country, :type => :model do
  subject(:country) { create :country }
  
  context 'association' do
    it { should have_many :addresses }
  end
  
  context 'validation' do
    it { should validate_presence_of(:name) }
  end
end  