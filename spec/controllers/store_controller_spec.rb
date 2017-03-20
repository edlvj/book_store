require 'rails_helper'
include Support::CanCanStub

describe StoreController, type: :controller do
  subject { create :book }
  let(:user) { create :user }
  
  before do
    sign_in user
  end
  
  describe 'GET #index' do
    it 'get presenter' do
      params = { sort: 'title_asc' }
      allow(controller).to receive(:params).and_return(params)
      expect(Books::MainPresenter).to receive(:new).with(params)
      get :index
    end
  end
  
end  