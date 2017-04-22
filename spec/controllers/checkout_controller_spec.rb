require 'rails_helper'

describe CheckoutController, type: :controller do
  let(:user) { create :user }

  before do
    sign_in user
  end
  
  describe 'GET #show' do
    context 'not able to perform' do
      let(:order) { create :order, :with_items, user: user }

      before do
        allow(controller).to receive(:current_order).and_return(order)
      end

      it 'flash alert' do
        get :show, params: { id: :delivery }
        expect(flash[:alert]).to eq I18n.t('flash.failure.step')
      end

      it 'delivery step' do
        get :show, params: { id: :delivery }
        expect(response).to redirect_to checkout_path(:address)
      end

      it 'payment step' do
        get :show, params: { id: :payment }
        expect(response).to redirect_to checkout_path(:delivery)
      end

      it 'confirm step' do
        get :show, params: { id: :confirm }
        expect(response).to redirect_to checkout_path(:payment)
      end

      it 'complete step' do
        get :show, params: { id: :complete }
        expect(response).to redirect_to checkout_path(:confirm)
      end
    end
  end 
  
  describe 'PUT #show' do
    let(:order) { create :order, user: user }
    let(:order_item) { create :order_item, qty: 1, order: order }
    let(:billing) { create(:type_address, :billing)}
    let(:shipping) { create(:type_address, :shipping)}
    let(:credit_card) { create(:credit_card)}
    
    before do
      allow(controller).to receive(:current_order).and_return(order)
    end  
    
    context 'address step' do
      let(:params) { { id: :address, order: {} } }
      
      before do
        order.order_shipping = shipping
        order.order_billing = billing
      end  

      it 'Checkout::AddressStep call' do
        expect(Checkout::AddressStep).to receive(:call)
        put :update, params: params
      end

      it 'success update' do
        stub_const('Checkout::AddressStep', Support::Command::Valid)
        put :update, params: params
        expect(response).to redirect_to checkout_path(:delivery)
      end

      it 'failure update' do
        stub_const('Checkout::AddressStep', Support::Command::Invalid)
        put :update, params: params
        expect(response).to render_template :address
      end
    end
    
    context 'delivery step' do
      let(:params) { { id: :delivery, order: {} } }
      
      before do
        order.order_shipping = shipping
        order.order_billing = billing
        order.shipping = create :shipping
      end  

      it 'Checkout::StepDelivery call' do
        expect(Checkout::DeliveryStep).to receive(:call)
        put :update, params: params
      end

      it 'success update' do
        stub_const('Checkout::DeliveryStep', Support::Command::Valid)
        put :update, params: params
        expect(response).to redirect_to checkout_path(:payment)
      end

      it 'failure update' do
        stub_const('Checkout::DeliveryStep', Support::Command::Invalid)
        put :update, params: params
        expect(response).to render_template :delivery
      end
    end
    
   context 'payment step' do
      let(:params) { { id: :payment, order: {} } }
      
      before do
        order.order_shipping = shipping
        order.order_billing = billing
        order.shipping = create :shipping
        order.credit_card = credit_card
      end  

      it 'Checkout::PaymentStep call' do
        expect(Checkout::PaymentStep).to receive(:call)
        put :update, params: params
      end

      it 'success update' do
        stub_const('Checkout::PaymentStep', Support::Command::Valid)
        put :update, params: params
        expect(response).to redirect_to checkout_path(:confirm)
      end

      it 'failure update' do
        stub_const('Checkout::PaymentStep', Support::Command::Invalid)
        put :update, params: params
        expect(response).to render_template :payment
      end
    end
    
    context 'confirm step' do
      let(:params) { { id: :confirm } }
      
      before do
        order.order_shipping = shipping
        order.order_billing = billing
        order.shipping = create :shipping
        order.credit_card = credit_card
      end  

      it 'Checkout::StepConfirm call' do
        expect(Checkout::ConfirmStep).to receive(:call)
        put :update, params: params
      end

      it 'success update' do
        stub_const('Checkout::ConfirmStep', Support::Command::Valid)
        put :update, params: params
        expect(response).to redirect_to checkout_path(:complete)
      end

      it 'failure update' do
        stub_const('Checkout::ConfirmStep', Support::Command::Invalid)
        put :update, params: params
        expect(response).to render_template :confirm
      end
    end
  end  
end  