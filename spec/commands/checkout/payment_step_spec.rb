require 'rails_helper'

RSpec.describe Checkout::PaymentStep do
  let(:order) { create :order}
  let(:user) { create :user }

  let(:params) do 
    ActionController::Parameters.new( order: { credit_card_attributes: attributes_for(:credit_card).to_h  }  )
  end
  
  let(:invalid_params) do
    ActionController::Parameters.new(order: { credit_card_attributes: attributes_for(:credit_card, :invalid) } )
  end

  describe "#call" do 

    context 'valid' do
      subject { Checkout::PaymentStep.new(order, params, user) }
      
      it 'set credit_card to order' do
        expect { subject.call }.to change(order, :credit_card)
      end
    
      it 'set broadcast' do
        expect { subject.call }.to broadcast(:valid)
      end
    end

    context 'invalid' do
      subject { Checkout::PaymentStep.new(order, invalid_params, user) }    
        
      it 'set broadcast' do
        expect { subject.call }.to broadcast(:invalid)
      end
    end
 
  end    
end  