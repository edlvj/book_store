require 'rails_helper'

RSpec.describe UpdateAddress do
  
  describe 'call' do
    let(:user) { create :user }
    let(:params) { { address: { shipping_address: attributes_for(:type_address, :shipping) } } }
    subject do
      UpdateAddress.new(user, params)
    end
  
    context 'valid' do
      before do
        subject.set_params(params[:address], { user_id: user.id })
        subject.set_addresses(user)
      end
  
      it 'create new addresses' do
        expect { subject.call }.to change { Address.count }.by(1)
      end
      
      it 'set broadcast valid' do
        expect { subject.call }.to broadcast(:valid)
      end
    end
  
    context 'invalid' do
      before do
        subject.set_params(params[:wrong], { user_id: user.id })
        subject.set_addresses(user)
      end
      
      it 'set broadcast invalid' do
        expect { subject.call }.to broadcast(:invalid)
      end
    end 
  end  
end