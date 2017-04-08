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
      params = { category: 'Mobile Development' }
      allow(controller).to receive(:params).and_return(params)
      expect(Books::IndexPresenter).to receive(:new).with(params)
      get :index
    end
  end
end  