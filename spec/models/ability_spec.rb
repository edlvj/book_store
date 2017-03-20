require 'rails_helper'
require 'cancan/matchers'

describe User, type: :model do
  let(:user) { create :user }
  let(:admin) { create :admin_user }
  let(:order) { create :order }

  context 'when user no logged' do
    subject { Ability.new }

    it { should be_able_to(:read, Book) }
    it { should be_able_to(:read, Category) }
    it { should be_able_to(:read, Review) }
  end
 
end  
