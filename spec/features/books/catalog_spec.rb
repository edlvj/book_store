require 'features/features_spec_helper'

describe 'Catalog List', type: :feature do
  before do
    30.times do |item|
      create :book
    end

    visit books_path
  end
  
   context 'Show Catalog List' do
    scenario 'contains 12 elements on page' do
      expect(page).to have_selector('.col-xs-6.col-sm-3', count: 12)
    end
    
    scenario 'books have links' do
      (1..12).each do |id|
        expect(page).not_to have_link(nil, href: "/books/#{id}")
      end
    end 
    
    scenario 'must go to cart path' do
      first('button.thumb-hover-link').click
      expect(page.current_path).to eq carts_path
    end  
  end
end  