require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let!(:user_author) { create(:user) }
  let(:question) { create(:question, user: user_author) }

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
      let(:create_question) { post :create, params: { question: attributes_for(:question) }, format: :js }

      it 'saves the new question in the database' do
        expect { create_question }.to change(Question, :count).by(1)
      end

      it 'render index' do
        create_question
        expect(response).to render_template :create
      end

      it 'question belongs to user' do
        create_question
        expect(assigns(:question).user_id).to eq @user.id
      end
    end

    context 'with invalid attributes' do
      let(:create_invalid_question) { post :create, params: { question: attributes_for(:invalid_question) }, format: :js }

      it 'does not save the question' do
        expect { create_invalid_question  }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        create_invalid_question
        expect(response).to render_template :create
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
          expect { delete :destroy, params: { id: question }, format: :js }.to change(Question, :count).by(-1)
        end

        it 'render destroy view' do
          delete :destroy, params: { id: question }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'An non-author' do
        before { sign_in(user_not_author) }
        it 'NOT delete the question in the database' do
          expect { delete :destroy, params: { id: question }, format: :js }.to_not change(Question, :count)
        end

        it 'render destroy view' do
          delete :destroy, params: { id: question }, format: :js
          expect(response).to render_template :destroy
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

  describe 'PATCH #update' do
    log_in_user

    let(:question) { create(:question, user: user_author) }
    let(:update_valid_question) { patch :update, params: { id: question, user: user_author, question: { body: 'new body', title: 'new title' }, format: :js } }

    before { update_valid_question }

    context 'with valid attributes' do
      it 'assings the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'assigns the questions' do
        expect(assigns(:question)).to eq Question.last
      end

      it "changes question`s attributes" do
        question.reload
        expect(question.body).to eq 'new body'
      end

      it 'render update template' do
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      let(:update_invalid_question) { patch :update, params: { id: question, user: user_author, question: attributes_for(:invalid_question), format: :js } }
      before { update_invalid_question }

      it "don't changes question`s attributes" do
        question.reload
        expect(question.title).to eq question.title
        expect(question.body).to eq question.body
      end

      it 'render update template' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'PATCH #set_best_answer_ever' do
    let!(:user_author) { create(:user) }
    let!(:user_not_author) { create(:user) }
    let!(:question) { create(:question, user: user_author) }
    let!(:answer) { create(:answer, question: question, user: user_author) }

    before { sign_in user_author }

    context 'As question author' do
      it 'save answer id as best_answer_id in question' do
        patch :set_best_answer_ever, params: { id: question, best_answer_id: answer.id, format: :js }
        question.reload
        expect(question.answers.where(best: true).ids[0]).to eq answer.id
      end
    end

    context 'As NOT question author' do
      it 'don`t save answer id as best_answer_id in question' do
        sign_in user_not_author
        patch :set_best_answer_ever, params: { id: question, best_answer_id: answer.id, format: :js }
        question.reload
        expect(question.answers.where(best: true).ids[0]).to_not eq answer.id
      end
    end

    it 'render template set_best_answer_ever' do
      patch :set_best_answer_ever, params: { id: question, best_answer_id: answer.id, format: :js }
      expect(response).to render_template :set_best_answer_ever
    end
  end
end
