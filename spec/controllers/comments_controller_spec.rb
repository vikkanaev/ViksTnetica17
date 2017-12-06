require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:question) { create(:question) }
  let(:valid_params) { { comment: attributes_for(:comment), question_id: question } }
  let(:invalid_params) { { comment: attributes_for(:invalid_comment), question_id: question } }

  describe 'POST #create' do
    context 'with valid attributes' do
      log_in_user

      it 'saves the new comment in the database' do
        expect { post :create, params: valid_params, format: :js }.to change(question.comments, :count).by(1)
      end

      it 'renders create template' do
        post :create, params: valid_params, format: :js
        expect(response).to render_template :create
      end

      it 'comment belongs to user' do
        post :create, params: valid_params, format: :js
        expect(assigns(:comment).user_id).to eq @user.id
      end
    end

    context 'with invalid attributes' do
      log_in_user

      it 'does not save the comment' do
        expect { post :create, params: invalid_params, format: :js }.to_not change(Comment, :count)
      end

      it 're-renders template create' do
        post :create, params: invalid_params, format: :js
        expect(response).to render_template :create
      end
    end
  end
end
