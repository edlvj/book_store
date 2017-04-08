require 'rails_helper'

RSpec.describe Books::CatalogPresenter do
  before do    
    @category = create :category
    @book = create_list(:book, 5, category: @category)
    @params = { sort: 'newest', category: @category.name, page: 1 }
  end
  
  subject { Books::CatalogPresenter.new(@params) }
  let(:books) { BookSort.new(:newest, @category.name, 1) }
  
  it '#catalog books' do
    allow(books).to receive(:query).and_return(Book)
    expect(subject.books.last).to eq Book.first
  end
end 