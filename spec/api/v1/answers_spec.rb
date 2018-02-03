require 'rails_helper'

describe 'Answers API' do
  describe 'GET /index' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/questions/1/answers', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/questions/1/answers', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end # context 'unauthorized'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question) { create(:question) }
      let!(:answers) { create_list(:answer, 2, question: question) }
      let(:answer) { answers.first }

      before { get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of question answers' do
        expect(response.body).to have_json_size(2)
      end

      %w(id body best created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end # context 'authorized'

  end # describe 'GET /index'

  describe 'GET /show' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/questions/1/answers', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/questions/1/answers', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end # context 'unauthorized'

    context 'authorized' do
      let(:question) { create(:question) }
      let(:access_token) { create(:access_token) }
      let(:answer) { create(:answer, question: question) }
      let!(:attachment) { create(:attachment, attachmentable: answer) }
      let!(:comment) { create(:comment, commentable: answer, user_id: answer.user) }

      before { get "/api/v1/answers/#{answer.id}/", params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end

      context 'attachments' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("attachments")
        end

        it 'has attachment url attr' do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("attachments/0/file/url")
        end
      end

      context 'comments' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("comments")
        end
        %w(id message commentable_type user_id commentable_id created_at updated_at).each do |attr|
          it "comment contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("comments/0/#{attr}")
          end
        end
      end # context 'comments'

    end # context 'authorized'

  end # describe 'GET /show'

end # describe 'Questions API'
