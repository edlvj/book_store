describe CreateReview do
  let(:user) { create :user }
  let(:book) { create :book }
  let(:params) { { review: attributes_for(:review) } }
  
end