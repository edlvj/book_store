require './features/features_spec_helper'

describe 'Header', type: :feature do
  before do
    visit root_path
  end  
    
  subject 'contains name of shop' do   
    expect(page.first('.navbar-brand').text).not_to eq("")
  end
    
  it 'contains sharing menu items' do
    expect(page.first('ul.nav.navbar-nav').text).to have_content I18n.t('navigation.home')
    expect(page.first('ul.nav.navbar-nav').text).to have_content I18n.t('navigation.shop')
    expect(page.first('.shop-quantity')).to have_content '0'
  end 
  
  context 'when user is not logged' do
    it 'available menu items' do
      expect(page.first('ul.nav.navbar-nav').text).to have_content I18n.t('navigation.log_in')
      expect(page.first('ul.nav.navbar-nav').text).to have_content I18n.t('navigation.sign_up')
      expect(page.first('ul.nav.navbar-nav').text).not_to have_content I18n.t('navigation.account')
    end
  end

  context 'when user is logged' do  
    let(:user) { create :user }
    
    before do
      login_as user, scope: :user
      visit root_path
    end  
    
    it 'available menu items' do
      expect(page.first('ul.nav.navbar-nav').text).to have_content I18n.t('navigation.account')
      expect(page.first('ul.nav.navbar-nav').text).to have_content I18n.t('navigation.log_out')
    end  
  end  
end  