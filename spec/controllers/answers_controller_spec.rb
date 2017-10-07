require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  describe 'POST #create' do
    let(:valid_params) { { answer: attributes_for(:answer), question_id: question } }
    let(:invalid_params) { { answer: attributes_for(:invalid_answer), question_id: question } }
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: valid_params }.to change(Answer, :count).by(1)
      end
      it 'renders parent question' do
        post :create, params: valid_params
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: invalid_params }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: invalid_params
        expect(response).to render_template :new
      end
    end
  end
end
