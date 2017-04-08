require 'rails_helper'

RSpec.describe ReviewForm, :review_form do
  subject { ReviewForm.new attributes_for(:review) }

  context 'validation' do
    %i(rating title comment).each do |name|
      it { should validate_presence_of(name) }
    end
    
    it { should validate_length_of(:title).is_at_most(60) }
    it { should validate_length_of(:comment).is_at_most(400) }
  end
end