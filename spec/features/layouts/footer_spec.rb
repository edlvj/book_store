require './features/features_spec_helper'

describe 'Footer', type: :feature do
  before do
    visit root_path
  end  
    
  scenario 'contains sharing menu items' do
    expect(page.first('ul.list-inline.mb-25').text).to have_content I18n.t('navigation.home')
    expect(page.first('ul.list-inline.mb-25').text).to have_content I18n.t('navigation.shop')
  end
  
  scenario 'contains phone and email' do
    expect(page.first('.general-nav-mail').text).to have_content 'support@bookstore.com'
    expect(page.first('.general-nav-number').text).to have_content '(555)-555-5555'
  end  
  
  scenario 'contains social link' do
    expect(page).to have_css ("i.fa.fa-facebook")
    expect(page).to have_css ("i.fa.fa-twitter")
    expect(page).to have_css ("i.fa.fa-google-plus")
    expect(page).to have_css ("i.fa.fa-instagram")
  end 

  context 'when user is logged' do  
    let(:user) { create :user }
    
    before do
      login_as user, scope: :user
      visit root_path
    end  
    
    scenario 'available items' do
      expect(page.first('.list-inline.mb-25').text).to have_content I18n.t('navigation.orders')
      expect(page.first('.list-inline.mb-25').text).to have_content I18n.t('navigation.settings')
    end  
  end  
end  