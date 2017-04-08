require 'rails_helper'

describe CheckoutController, type: :controller do
  let(:user) { create :user }
  
  before do
    sign_in user
  end
  
  describe 'GET #show' do
    context 'able to perform' do
      let(:order) { create :order, :checkout_package, user: user }

      before do
        allow(controller).to receive(:current_order).and_return(order)
      end

      it 'address step' do
        get :show, params: { id: :address }
        expect(response).to render_template :address
      end

      it 'delivery step' do
        get :show, params: { id: :delivery }
        expect(response).to render_template :delivery
      end

      it 'payment step' do
        get :show, params: { id: :payment }
        expect(response).to render_template :payment
      end

      it 'confirm step' do
        get :show, params: { id: :confirm }
        expect(response).to render_template :confirm
      end

      it 'complete step' do
        order.queued!
        get :show, params: { id: :complete }
        expect(response).to render_template :complete
      end
    end
  end    
    
end  