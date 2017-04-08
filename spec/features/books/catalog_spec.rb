require 'features/features_spec_helper'

describe 'Catalog List', type: :feature do
  
  before do
    create_list(:book, 30) 
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
      first('button.thumb-hover-link.buy').click
      expect(page).to have_content(I18n.t('flash.success.book_add', count: 1))
    end 
  
  end
end  