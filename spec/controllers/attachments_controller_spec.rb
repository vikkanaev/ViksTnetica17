require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  describe 'DELETE #destroy' do
    let!(:user_author) { create(:user) }
    let!(:user_not_author) { create(:user) }
    let!(:question) { create(:question, user: user_author) }
    let!(:author_answer) { create(:answer, user: user_author, question: question) }
    let!(:attachment) { create(:attachment, attachmentable: question) }

    before { question }

    context 'LogedIn user' do
      context 'As author' do
        before { sign_in(user_author) }

        it 'delete the attachment in the database' do
          expect { delete :destroy, params: { id: attachment }, format: :js }.to change(Attachment, :count).by(-1)
        end

        it 'render destroy view' do
          delete :destroy, params: { id: attachment }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'An non-author' do
        before { sign_in(user_not_author) }

        it 'NOT delete the attachment in the database' do
          expect { delete :destroy, params: { id: attachment }, format: :js }.to_not change(Attachment, :count)
        end

        it 'render destroy view' do
          delete :destroy, params: { id: attachment }, format: :js
          expect(response).to render_template :destroy
        end
      end
    end

    context 'NotLogedIn user' do
      it 'NOT delete the attachment in the database' do
        expect { delete :destroy, params: { id: attachment } }.to_not change(Attachment, :count)
      end

      it 'redirect to sign_in page' do
        delete :destroy, params: { id: attachment }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
