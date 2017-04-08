require 'rails_helper'
require 'cancan/matchers'

describe User, type: :model do
  let(:user) { create :user }
  let(:admin) { create :admin_user }
  let(:order) { create :order }

  context 'when user no logged' do
    subject { Ability.new(nil) }
    [Book, Category, Review].each do |model_name|
      it { should be_able_to(:read, model_name.new) }
    end
  end
  
  context 'when user signed in' do
    subject { Ability.new(user) }
    
    [Book, Category, Order].each do |model_name|
      it { should be_able_to(:read, model_name.new) }
    end
    
    it { should be_able_to(:create, Review) }
    it { should be_able_to(:update, Coupon) }
    it { should be_able_to(:manage, user) }
    it { should be_able_to(:manage, OrderItem) }
  end
  
  context 'when user as admin' do
    subject { Ability.new(admin) }
    [Author, Book, Category, AdminUser, OrderItem, Order].each do |model_name|
      it { should be_able_to(:manage, model_name.new) }
    end
  end  
end  
