require 'features/features_spec_helper'
include Support::Book

feature 'User create review', type: :feature do
  let(:user) { create :user }
  let(:book) { create :book }
  
  background do
    login_as(user, scope: :user)
    visit book_path(id: book.id)
  end
  
  scenario 'User fill valid data' do
    fill_review('review_form', attributes_for(:review))
    expect(page).to have_content(I18n.t('flash.success.created_review'))
  end
  
 # scenario 'User fill invalid data' do
 #   fill_review('review_form', attributes_for(:review, :invalid))
  #  expect(page).to have_content(I18n.t('flash.failure.created_review'))
 # end
end  