require 'rails_helper'

RSpec.describe Order, :order, :type => :model do
  subject(:order) { create :order }
  
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:shipping) }
    it { should have_many(:order_items) }

    %i(coupon credit_card order_shipping order_billing).each do |model_name|
      it { should have_one(model_name) }
    end
    it { should accept_nested_attributes_for(:order_items) }
  end
  
  context 'aasm states' do
    it 'in_progress -> in_queue' do
      expect(subject).to transition_from(:in_progress).to(:in_queue)
        .on_event(:queued)
    end
    it 'in_queue -> in_delivery' do
      expect(subject).to transition_from(:in_queue).to(:in_delivery)
        .on_event(:to_deliver)
    end
    it 'in_delivery -> delivered' do
      expect(subject).to transition_from(:in_delivery).to(:delivered)
        .on_event(:end_deliver)
    end
    it 'in_progress -> cancel' do
      expect(subject).to transition_from(:in_progress).to(:canceled)
        .on_event(:cancel)
    end
  end
end  