require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    log_in_user
    before { get :new }

    it 'assigns a new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    log_in_user
    before { get :edit, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    log_in_user

    context 'with valid attributes' do
      let(:create_question) { post :create, params: { question: attributes_for(:question) } }

      it 'saves the new question in the database' do
        expect { create_question }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        create_question
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it 'question belongs to user' do
        create_question
        expect(assigns(:question).user_id).to eq @user.id
      end
    end

    context 'with invalid attributes' do
      let(:create_invalid_question) { post :create, params: { question: attributes_for(:invalid_question) } }

      it 'does not save the question' do
        expect { create_invalid_question  }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        create_invalid_question
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'LogedIn user' do
      let!(:user_author) { create(:user) }
      let!(:user_not_author) { create(:user) }
      let!(:question) { create(:question, user: user_author) }
      let!(:non_author_question) { create(:question, user: user_not_author) }

      before { question }

      context 'As author' do
        before { sign_in(user_author) }
        it 'delete the question in the database' do
          expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
        end

        it 'redirect to index view' do
          delete :destroy, params: { id: question }
          expect(response).to redirect_to questions_path
        end
      end

      context 'An non-author' do
        before { sign_in(user_not_author) }
        it 'NOT delete the question in the database' do
          expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
        end

        it 'redirect to this question show' do
          delete :destroy, params: { id: question }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end
    end

    context 'NotLogedIn user' do
      before { get :edit, params: { id: question } }
      it 'NOT delete the question in the database' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end

      it 'redirect to sign_in page' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
