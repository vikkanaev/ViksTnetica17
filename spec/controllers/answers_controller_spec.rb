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
    let!(:user_author) { create(:user) }
    let!(:user_not_author) { create(:user) }
    let!(:question) { create(:question, user: user_author) }
    let!(:author_answer) { create(:answer, user: user_author) }
    before { question }

    context 'LogedIn user' do
      context 'As author' do
        before { sign_in(user_author) }

        it 'delete the question in the database' do
          expect { delete :destroy, params: { id: author_answer } }.to change(Answer, :count).by(-1)
        end

        it 'redirect to index view' do
          delete :destroy, params: { id: author_answer }
          expect(response).to redirect_to question_path(author_answer.question)
        end
      end
      context 'An non-author' do
        before { sign_in(user_not_author) }

        it 'NOT delete the question in the database' do
          expect { delete :destroy, params: { id: author_answer } }.to change(Answer, :count).by(0)
        end
        it 'redirect to this question show' do
          delete :destroy, params: { id: author_answer }
          expect(response).to redirect_to question_path(author_answer.question)
        end
      end
    end

    context 'NotLogedIn user' do
      it 'NOT delete the question in the database' do
        expect { delete :destroy, params: { id: author_answer } }.to change(Answer, :count).by(0)
      end
      it 'redirect to sign_in page' do
        delete :destroy, params: { id: author_answer }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
