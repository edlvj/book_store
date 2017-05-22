require 'rails_helper'

describe 'Home', type: :feature do
  before do
    @mob_cat = create :category, name: 'Mobile Development'
    @web_cat = create :category, name: 'Web development'
    
    20.times do |items|
      create :order_with_book,
             book_id: items,
             qty: (items < 4) ? 2 : 1,
             category_id: @mob_cat.id
    end

    visit root_path
  end
  
  context 'latests books ' do
    it 'cantains 3 elemets' do
      expect(page).to have_selector('body#slider.carousel-inner.item', count: 3)
    end  
  end 
  
  context 'get stared' do
    it 'contains button' do
      expect(page).to have_content I18n.t('store.get_started')
    end  
    
    it 'click on button have books_path' do
      find('.btn.btn-default', I18n.t('store.get_started')).click
      expect(page.current_path).to eq books_path
    end
  end

  context 'bestsellers' do
    it 'conatains 4 elements' do
      expect(page).to have_selector('.thumbnail.general-thumbnail', count: 4)
    end  
   
    it 'have books path' do
      (0..3).each do |id|
        expect(page).to have_link(nil, href: "/books/#{id}")
      end
    end
  end  
end  