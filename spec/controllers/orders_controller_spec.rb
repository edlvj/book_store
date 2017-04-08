require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create :user }
  
  before do
    sign_in user
    allow(Order).to receive(:find_by).and_return(subject)
  end
  
  describe 'GET #index' do
    it 'assigns states' do
      get :index
      expect(assigns[:states]).not_to be_nil
    end

    it 'assigns orders with sort' do
      get :index, params: { state: 'in_progress' }
      expect(response).to render_template :index
    end

  end    
end  