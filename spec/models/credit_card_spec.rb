require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  subject { build :credit_card }

  context 'association' do
    it { should belong_to :user }
    it { should have_many :order }
  end
end