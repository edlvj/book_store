require 'rails_helper'

RSpec.describe UpdateOrder do
  let(:order) { create :order, :with_items }
  let(:order_item) { order.order_items.first }

  context 'update order items' do
    context 'success update' do
      let(:params) do
        { order: { order_items_attributes: { id: order_item.id,
                                             qty: 20 } } }
      end
      subject { UpdateOrder.new(order, params) }
      
      before do
        allow(subject).to receive(:order_params).and_return(params[:order])
      end

      it 'valid broadcast' do
        expect { subject.call }.to broadcast(:valid)
      end

      it 'checkout broadcast' do
        params[:to_checkout] = true
        expect { subject.call }.to broadcast(:checkout)
      end
    end
    
    context 'check' do
      let(:params) do
        { order: { order_items_attributes: { id: order_item.id,
                                             qty: -2} } }
      end
      subject { UpdateOrder.new(order, params) }
      before do
        allow(subject).to receive(:order_params)
          .and_return(params[:order])
      end
      it 'invalid broadcast' do
        expect { subject.call }.to broadcast(:invalid)
      end
    end
    
  end
end  