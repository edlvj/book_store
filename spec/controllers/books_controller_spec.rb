require 'rails_helper'
include Support::CanCanStub

RSpec.describe BooksController, type: :controller do
  subject { create :book }
  let(:user) { create :user }
  
  before do
    sign_in user
  end
  
  describe 'GET #index' do
    it 'get presenter' do
      params = { sort: 'asc_title' }
      allow(controller).to receive(:params).and_return(params)
      expect(Books::CatalogPresenter).to receive(:new).with(params)
      get :index
    end
  end
  
  describe 'GET #show' do
    context 'when book found' do
      before do
        get :show, params: { id: subject.id }
      end
      it 'assigns book' do
        expect(assigns(:book)).to eq(subject)
      end
      it 'renders the :show template' do
        expect(response).to render_template(:show)
      end
    end
  end
  
  describe 'PUT #update' do
    let(:params) { { id: subject.id, review: attributes_for(:review) } }

    it 'CreateReview call' do
      allow(controller).to receive(:params).and_return(params)
      receive_cancan(:load_and_authorize, book: subject)
      expect(CreateReview).to receive(:call)
        .with(user: user, book: subject, params: params)
      put :update, params: params
    end
    
    context 'success update' do
      before do
        stub_const('CreateReview', Support::Command::Valid)
        Support::Command::Valid.block_value = subject
        put :update, params: params
      end
      it 'flash notice' do
        expect(flash[:notice]).to eq(I18n.t('flash.success.created_review'))
      end
      
      it 'redirect to book' do
        expect(response).to redirect_to(subject)
      end
    end
    
    context 'failure update' do
      let(:review_form) { double('review_form') }
      before do
        stub_const('CreateReview', Support::Command::Invalid)
        Support::Command::Invalid.block_value = review_form
        put :update, params: params
      end
      it 'flash notice' do
        expect(flash[:alert]).to eq(I18n.t('flash.failure.created_review'))
      end
      it 'redirect to book' do
        expect(response).to render_template(:show)
      end
    end

  end 
end  