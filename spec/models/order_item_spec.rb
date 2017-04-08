require 'rails_helper'

RSpec.describe OrderItem, :order_item, :type => :model do
    subject(:order_item) { create :order_item }
    
  context 'association' do
    it { should belong_to(:book) }
    it { should belong_to(:order) }
  end
  
  context 'validation' do
    it { should validate_presence_of(:qty) }  
  end  
  
  it '#sub_total' do
    subject.book = create :book, price: 10
    subject.qty = 2
    expect(subject.sub_total).to eq(20)
  end
end    