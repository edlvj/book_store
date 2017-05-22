require 'rails_helper'

RSpec.describe CreateReview do
  let(:user) { create :user }
  let(:book) { create :book }
  let(:params) { { review: attributes_for(:review) } }
  
  context '#call' do
    subject { CreateReview.new(user: user, book: book, params: params) }

    context 'valid' do
      it 'set valid broadcast' do
        expect { subject.call }.to broadcast(:valid)
      end
      it 'set processing state' do
        expect { subject.call }.to change { Review.count }.by(1)
      end
    end
    
    it 'invalid' do
      invalid_params = { review: attributes_for(:review, :invalid) }
      allow(subject).to receive(:params).and_return(invalid_params)
      expect { subject.call }.to broadcast(:invalid)
    end
  end
end