require 'rails_helper'

RSpec.describe AddToCart do
  let(:order) { create :order, :with_items }
  let(:item) { order.order_items.first }
  let(:book_id) { item.book.id }
  let(:params) { { book_id: book_id, quantity: 2 } }
  let(:invalid_params) { { book_id: nil, quantity: 'fdfd' } }

  context '#call' do
    subject { AddToCart.new(order, params) }

    it 'valid broadcast' do
      expect { subject.call }.to broadcast(:valid)
    end
    
    it 'invalid broadcast' do
      subject = AddToCart.new(order, invalid_params)
      expect { subject.call }.to broadcast(:invalid)
    end
  end    
  
end  