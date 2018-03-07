require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do # rubocop:disable Metrics/BlockLength
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:subscription) { create(:subscription, question: question, user: other_user) }

  describe 'POST #create' do
    context 'signed_in user' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[other_user]
        sign_in other_user
      end

      it 'creates new subscription' do
        expect { post :create, params: { id: question.id }, format: :js }.to change(Subscription, :count).by(1)
      end

      it 'renders act.js' do
        post :create, params: { id: question.id }, format: :js
        expect(response).to render_template :act
      end
    end

    context 'not signed_in user' do
      it 'cant create new subscription' do
        expect { post :create, params: { id: question.id }, format: :js }.to_not change(Subscription, :count)
      end

      it 'responds with status 401' do
        post :create, params: { id: question.id }, format: :js
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'DELETE #destroy' do # rubocop:disable Metrics/BlockLength
    context 'signed_in user can unsubscribe' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[other_user]
        sign_in other_user
        subscription
      end

      it 'delete subscription' do
        expect { delete :destroy, params: { id: subscription.id, format: :js } }.to change(Subscription, :count).by(-1)
      end

      it 'render act' do
        delete :destroy, params: { id: subscription.id, format: :js }
        expect(response).to render_template :act
      end
    end

    context 'not signed_in user cant unsubscribe' do
      before { subscription }
      it 'cant delete subscription' do
        expect { delete :destroy, params: { id: subscription.id, format: :js } }.to_not change(Subscription, :count)
      end

      it 'doesnt render act' do
        delete :destroy, params: { id: subscription.id, format: :js }
        expect(response.status).to eq(401)
      end
    end
  end
end
