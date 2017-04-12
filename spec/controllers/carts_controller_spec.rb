require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  subject { create :order, :with_items }
  let(:order_item) { subject.order_items.first }
  let(:coupon) { create :coupon }
  
  before do
    allow(controller).to receive(:current_order).and_return(subject)
  end
  
  describe 'GET #index' do
    it 'assign coupon' do
      allow(Coupon).to receive(:new)
      get :index
    end
  end
  
  describe 'POST #create' do
    let(:book_id) { order_item.book.id }
    let(:params) { { book_id: book_id, quantity: 20 } }  
    
    it 'AddToCart call' do
      allow(controller).to receive(:params).and_return(params)
      expect(AddToCart).to receive(:call).with(subject, params)
      put :create
    end
    
    context 'success call' do
      before do
        stub_const('AddToCart', Support::Command::Valid)
        Support::Command::Valid.block_value = 20
        put :create
      end
      it 'notice flash' do
        expect(flash[:notice]).to eq I18n.t('flash.success.book_add', count: 20)
      end
      it 'redirect_back' do
        expect(response).to redirect_to(root_path)
      end
    end
    
    context 'failure call' do
      before do
        stub_const('AddToCart', Support::Command::Invalid)
        Support::Command::Invalid.block_value = 'errors'
        put :create
      end
      it 'alert flash' do
        expect(flash[:alert]).to eq I18n.t('flash.failure.book_add',
                                           errors: 'errors')
      end
      it 'redirect_back' do
        expect(response).to redirect_to(root_path)
      end
    end
  end 
  
  describe 'PUT #update' do
    let(:params) { { coupon: { code: coupon.code } } } 

    it 'UpdateOrder call' do
      allow(controller).to receive(:params).and_return(params)
      expect(UpdateOrder).to receive(:call).with(subject, params)
      patch :update, params: params
    end
    
    context 'success update' do
      before do
        stub_const('UpdateOrder', Support::Command::Valid)
        put :update, params: params
      end
      it 'flash notice' do
        expect(flash[:notice]).to eq(I18n.t('flash.success.cart_update'))
      end
      it 'redirect to edit user' do
        expect(response).to redirect_to(carts_path)
      end
    end
    
    context 'success update to checkout' do
      before do
        stub_const('UpdateOrder', Support::Command::Checkout)
        put :update, params: params
      end
      it 'redirect to checkout' do
        expect(response).to redirect_to(checkout_path(:address))
      end
    end
    
    context 'failure update' do
      before do
        stub_const('UpdateOrder', Support::Command::Invalid)
        Support::Command::Invalid.block_value = coupon
        put :update, params: params
      end
      it 'flash notice' do
        expect(flash[:alert]).to eq(I18n.t('flash.failure.cart_update' ))
      end
      it 'redirect to edit user' do
        expect(response).to render_template(:index)
      end
    end
  end 
  
  describe 'DELETE #destroy' do
    before do
      subject { order.order_items.first }
      allow(OrderItem).to receive(:find).and_return(subject)
    end
    context 'success destroy' do
      before do
        allow(subject).to receive(:destroy).and_return(true)
        allow(order).to receive(:save).and_return(true)
        delete :destroy, params: { id: subject.id }
      end
    end
    
    it 'notice flash' do
      expect(flash[:notice]).to eq I18n.t('flash.success.book_destroy', title: subject.order_items.book.title)
    end
    it 'redirect to cart' do
      expect(response).to redirect_to(carts_path)
    end
  end    
end    