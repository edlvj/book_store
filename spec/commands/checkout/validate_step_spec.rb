require 'rails_helper'

RSpec.describe Checkout::ValidateStep do
  let(:user) { create :user }
  let(:billing) { create(:type_address, :billing)}
  let(:shipping) { create(:type_address, :shipping)}
  let(:credit_card) { create(:credit_card)}

  describe '#call' do
    context 'When ok' do
      let(:order) { create :order, :with_items, user: user }

      it ':address step' do
        subject = Checkout::ValidateStep.new(:address, order)
        expect { subject.call }.to broadcast(:ok)
      end

      it ':delivery step' do
        order.order_shipping = shipping
        order.order_billing = billing
        subject = Checkout::ValidateStep.new(:delivery, order)
        expect { subject.call }.to broadcast(:ok)
      end
      
      it ':payment step' do
        order.order_shipping = shipping
        order.order_billing = billing
        order.shipping = create :shipping
        subject = Checkout::ValidateStep.new(:payment, order)
        expect { subject.call }.to broadcast(:ok)
      end

      it ':confirm step' do
        order.order_shipping = shipping
        order.order_billing = billing
        order.shipping = create :shipping
        order.credit_card = credit_card
        subject = Checkout::ValidateStep.new(:payment, order)
        expect { subject.call }.to broadcast(:ok)
      end
      
       it ':complete step' do
        order.order_shipping = shipping
        order.order_billing = billing
        order.shipping = create :shipping
        order.credit_card = credit_card
        order.queued
        subject = Checkout::ValidateStep.new(:complete, order)
        expect { subject.call }.to broadcast(:ok)
      end
    end
    
    context 'When empty_cart' do
      it ':delivery step' do
        subject = Checkout::ValidateStep.new(:address, nil)
        expect { subject.call }.to broadcast(:invalid)
      end
    end
  end
end