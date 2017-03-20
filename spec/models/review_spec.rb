require 'rails_helper'

describe Review, type: :model do
  subject { build :review }

  context 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end

  context 'aasm state change' do
    it 'pending -> approved' do
      expect(subject).to transition_from(:pending).to(:approved)
        .on_event(:approve)
    end
    it 'pending -> declined' do
      expect(subject).to transition_from(:pending).to(:declined)
        .on_event(:decline)
    end
  end
end