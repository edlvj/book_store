require 'rails_helper'

RSpec.describe Book, :book, :type => :model do
  subject(:book) { create :book }

  context 'association' do
    it { should belong_to :category }
    it { should have_and_belong_to_many :author }
    it { should have_many :order_items}
    it { should have_many :reviews }
  end      

  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end
end  