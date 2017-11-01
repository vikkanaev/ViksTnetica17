require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let(:valid_params) { { answer: attributes_for(:answer), question_id: question } }
  let(:invalid_params) { { answer: attributes_for(:invalid_answer), question_id: question } }

  describe 'POST #create' do
    context 'with valid attributes' do
      log_in_user

      it 'saves the new answer in the database' do
        expect { post :create, params: valid_params, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'renders create template' do
        post :create, params: valid_params, format: :js
        expect(response).to render_template :create
      end

      it 'answer belongs to user' do
        post :create, params: valid_params, format: :js
        expect(assigns(:answer).user_id).to eq @user.id
      end
    end

    context 'with invalid attributes' do
      log_in_user

      it 'does not save the answer' do
        expect { post :create, params: invalid_params, format: :js }.to_not change(Answer, :count)
      end

      it 're-renders template create' do
        post :create, params: invalid_params, format: :js
        expect(response).to render_template :create
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

        it 'Delete best_answer_id from parent question if answer is Best'
      end

      context 'An non-author' do
        before { sign_in(user_not_author) }

        it 'NOT delete the question in the database' do
          expect { delete :destroy, params: { id: author_answer } }.to_not change(Answer, :count)
        end

        it 'redirect to this question show' do
          delete :destroy, params: { id: author_answer }
          expect(response).to redirect_to question_path(author_answer.question)
        end
      end
    end

    context 'NotLogedIn user' do
      it 'NOT delete the question in the database' do
        expect { delete :destroy, params: { id: author_answer } }.to_not change(Answer, :count)
      end

      it 'redirect to sign_in page' do
        delete :destroy, params: { id: author_answer }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user_author) { create(:user) }
    let!(:answer) { create(:answer, question: question, user: user_author) }
    before { sign_in(user_author) }

    it 'assings the requested answer to @answer' do
      patch :update, params: { question_id: question, id: answer, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns the question' do
      patch :update, params: { question_id: question, id: answer, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, question_id: question, answer: { body: 'new body' } }, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(response).to render_template :update
    end
  end
end
