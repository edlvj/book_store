require 'rails_helper'
include Support::CanCanStub

RSpec.describe Users::RegistrationsController, type: :controller do
  subject { create :user }
 
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
  
  describe 'PUT #update' do
    before(:each) do
      sign_in subject
      receive_cancan(:load_and_authorize)
    end

    context 'UpdateUser' do
      let(:params) { { email: subject.email } }
      before { allow(controller).to receive(:params).and_return(params) }

      it 'UpdateUser call' do
        expect(UpdateUser).to receive(:call).with(subject, params)
        put :update, params: params
      end
      
      context 'success update' do
        before do
          stub_const('UpdateUser', Support::Command::Valid)
          put :update
        end
        it 'flash notice' do
          expect(flash[:notice]).to eq(I18n.t('flash.success.privacy_update'))
        end
        it 'redirect to edit user' do
          expect(response).to redirect_to(setting_path)
        end
      end
      
      context 'failure update' do
        before do
          stub_const('UpdateUser', Support::Command::Invalid)
          put :update
        end
        it 'flash notice' do
          expect(flash[:alert]).to eq(I18n.t('flash.failure.privacy_update'))
        end
        it 'redirect to edit user' do
          expect(response).to render_template(:edit)
        end
      end
      
    end
  end    
end  