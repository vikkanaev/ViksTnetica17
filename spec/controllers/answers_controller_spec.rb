require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:valid_params) { { answer: attributes_for(:answer), question_id: question } }
  let(:invalid_params) { { answer: attributes_for(:invalid_answer), question_id: question } }
  describe 'POST #create' do
    context 'with valid attributes' do
      log_in_user
      it 'saves the new answer in the database' do
        expect { post :create, params: valid_params }.to change(question.answers, :count).by(1)
      end
      it 'renders parent question' do
        post :create, params: valid_params
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      log_in_user
      it 'does not save the answer' do
        expect { post :create, params: invalid_params }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post :create, params: invalid_params
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    log_in_user

    it 'delete the answer in the database' do
      post :create, params: valid_params
      answer_id = Answer.last.id
      expect { delete :destroy, params: { id: answer_id } }.to change(Answer, :count).by(-1)
    end

    it 'redirect to index view' do
      post :create, params: valid_params
      answer_id = Answer.last.id
      delete :destroy, params: { id: answer_id }
      expect(response).to redirect_to question_path(question)
    end

  end
end
