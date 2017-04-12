require 'rails_helper'

RSpec.describe Checkout::AddressStep do
  describe 'call' do
    let(:order) { create :order }
    let(:user) { create :user }
    let(:params) { { order: { billing_address: attributes_for(:type_address, :billing) } } }
    let(:local_params) { { user_id: user.id, order_id: order.id } }
    
    subject { Checkout::AddressStep.new(order, params, user) }
  
    context 'valid' do
      before do
        subject.set_params(params[:order], local_params , true)
        subject.set_addresses(user)
      end
      
      it 'set broadcast valid' do
        expect { subject.call }.to broadcast(:valid)
      end
    end
    
    context 'invalid' do
      before do
        subject.set_params(nil, local_params)
        subject.set_addresses(user)
      end
      
      it 'set broadcast valid' do
        expect { subject.call }.to broadcast(:invalid)
      end
    end
  end  
end
    