require 'rails_helper'

RSpec.describe UpdateAddress do
  
  context 'valid' do
    let(:params) { { address: attributes_for(:type_address, :shipping) } }
    let(:user) { create :user }
   
    subject do
      UpdateAddress.new(user: user, params: params)
    end

    let(:shipping) do
      AddressForm.new(params[:address])
    end

   # before do
   #   expect_any_instance_of(UpdateAddress)
   #     .to receive(:set_params).with( params[:address], { user_id: user.id })
  #     .and_return(shipping)
  #  end

    it 'create new addresses' do
      expect { subject.call }.to change { Address.count }.by(1)
    end
    
    it 'set broadcast' do
      expect { subject.call }.to broadcast(:valid)
    end
  end
end