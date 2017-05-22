require 'rails_helper'

feature 'Show book' do
  let(:book) { create(:book) }
 
  background do
    visit book_path(id: book.id)
  end
  
  scenario 'Must show book attributes' do
    expect(page).to have_content book.title
    expect(page).to have_content book.price
  end
  
  scenario 'Must redirect to cart path' do
    find('.btn.btn-default', I18n.t('book.add_to_cart')).click
    expect(page).to have_content(I18n.t('flash.success.book_add', count: 1))
  end  
end  