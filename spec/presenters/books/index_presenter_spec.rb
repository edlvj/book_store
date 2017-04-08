require 'rails_helper'

RSpec.describe Books::IndexPresenter do
  before do
    @category = create :category
    @book = create :book, category: @category
    @order_item = create :order_item, book: @book
    @params = { category: @category.name }
  end
  
  subject { Books::IndexPresenter.new(@params) }
  let(:bookNew) { BookSort.new(:newest, @category.name) }
  let(:bookPopular) { BookSort.new(:popular, @category.name) }
  
  context '#books' do
    it '#latest' do
      allow(bookNew).to receive(:query).and_return(Book)
      expect(subject.lastest.last).to eq Book.first
    end
  
    it '#bestsellers' do
      allow(bookPopular).to receive(:query).and_return(Book)
      expect(subject.bestsellers.last).to eq Book.first
    end
    
    it '#category' do
      expect(subject.category).to eq @category.name
    end  
  end
end 