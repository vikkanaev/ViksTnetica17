require 'rails_helper'

describe 'Questions API' do
  describe 'GET /index' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token } }

      it_behaves_like "API be_success"

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2)
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      it 'question object contains short_title' do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("0/short_title")
      end

      context 'answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/answers")
        end

        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end # context 'answers'
    end # context 'authorized'

    def do_request(options = {})
      get '/api/v1/questions', params: { format: :json }.merge(options)
    end
  end # describe 'GET /index'

  describe 'GET /show' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:question) { create(:question) }
      let(:access_token) { create(:access_token) }
      let(:answer) { create(:answer, question: question) }
      let!(:attachment) { create(:attachment, attachmentable: question) }
      let!(:comment) { create(:comment, commentable: question, user_id: question.user) }

      before { get "/api/v1/questions/#{@question_id}", params: { format: :json, access_token: access_token.token } }

      it_behaves_like "API be_success"

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'attachments' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/attachments")
        end

        it 'has attachment url attr' do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("0/attachments/0/file/url")
        end
      end

      context 'comments' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/comments")
        end
        %w(id message commentable_type user_id commentable_id created_at updated_at).each do |attr|
          it "comment contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("0/comments/0/#{attr}")
          end
        end
      end # context 'comments'
    end # context 'authorized'

    def do_request(options = {})
      get '/api/v1/questions/1', params: { format: :json }.merge(options)
    end
  end # describe 'GET /show'

  describe 'POST /create' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let!(:question) { create(:question) }
      let(:access_token) { create(:access_token) }

      before { post '/api/v1/questions/', params: { action: :create, format: :json, question: attributes_for(:question), access_token: access_token.token }}

      it_behaves_like "API be_success"

      it 'create question' do
        expect{post '/api/v1/questions/', params: { action: :create, format: :json,
                 question: attributes_for(:question), access_token: access_token.token }}.to change(Question, :count).by(1)
      end
    end # context 'authorized'

    def do_request(options = {})
      post '/api/v1/questions/', params: { action: :create, format: :json, question: attributes_for(:question).merge(options) }
    end
  end # describe 'POST /create'
end # describe 'Questions API'
