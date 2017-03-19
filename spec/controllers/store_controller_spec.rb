require 'rails_helper'
include Support::CanCanStub

describe BooksController, type: :controller do
  subject { create :book }
  let(:user) { create :user }
  
  before do
    sign_in user
  end
  
  describe 'GET #index' do
    it 'get presenter' do
      params = { sort: 'title_asc' }
      allow(controller).to receive(:params).and_return(params)
      expect(Books::MainPresenter).to receive(:new).with(params)
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

      it 'assigns the requested book' do
        expect(assigns(:book)).to eq(subject)
      end
      it 'renders the :show template' do
        expect(response).to render_template(:show)
      end
    end
  end

end  