require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:question_user_1) { create(:question, user: user_1) }
  let!(:question_user_2) { create(:question, user: user_2) }
  let!(:answer_user_1) { create(:answer, user: user_1, question: question_user_1) }
  let!(:answer_user_2) { create(:answer, user: user_2, question: question_user_2) }

  describe 'PATCH #vote_up' do
    context 'User voting for other users question' do
      before { sign_in(user_2) }

      it 'save user vote in votable' do
        expect{ patch :vote_up, params: { question_id: question_user_1, format: :js } }.to change(Vote, :count).by(+1)
      end

      it 'return success message in json' do
        patch :vote_up, params: { question_id: question_user_1, format: :js }
        expect(response.body).to eq({ id: question_user_1.id, score: question_user_1.sum_score, have_vote: true, type: question_user_1.class.to_s }.to_json)
      end
    end

    context 'User voting for his question' do
      before { sign_in(user_1) }
      it 'NOT save user vote in votable' do
        expect{ patch :vote_up, params: { question_id: question_user_1, format: :js } }.to_not change(Vote, :count)
      end

      it 'return error message in json' do
        patch :vote_up, params: { question_id: question_user_1, format: :js }
        expect(response.body).to eq({message: "You can`t vote for your Question"}.to_json)
      end
    end

    # ANSWERS
    context 'User voting for other users answer' do
      before { sign_in(user_2) }

      it 'save user vote in votable' do
        expect{ patch :vote_up, params: { answer_id: answer_user_1, format: :js } }.to change(Vote, :count).by(+1)
      end

      it 'return success message in json' do
        patch :vote_up, params: { answer_id: answer_user_1, format: :js }
        expect(response.body).to eq({ id: answer_user_1.id, score: answer_user_1.sum_score, have_vote: true, type: answer_user_1.class.to_s }.to_json)
      end
    end

    context 'User voting for his answer' do
      before { sign_in(user_1) }
      it 'NOT save user vote in votable' do
        expect{ patch :vote_up, params: { answer_id: answer_user_1, format: :js } }.to_not change(Vote, :count)
      end

      it 'return error message in json' do
        patch :vote_up, params: { answer_id: answer_user_1, format: :js }
        expect(response.body).to eq({message: "You can`t vote for your Answer"}.to_json)
      end
    end
  end

  describe 'PATCH #vote_down' do
    context 'User voting for other users question' do
      before { sign_in(user_2) }

      it 'save user vote in votable' do
        expect{ patch :vote_down, params: { question_id: question_user_1, format: :js } }.to change(Vote, :count).by(+1)
      end

      it 'return success message in json' do
        patch :vote_down, params: { question_id: question_user_1, format: :js }
        expect(response.body).to eq({ id: question_user_1.id, score: question_user_1.sum_score, have_vote: true, type: question_user_1.class.to_s }.to_json)
      end
    end

    context 'User voting for his question' do
      before { sign_in(user_1) }
      it 'NOT save user vote in votable' do
        expect{ patch :vote_down, params: { question_id: question_user_1, format: :js } }.to_not change(Vote, :count)
      end

      it 'return error message in json' do
        patch :vote_down, params: { question_id: question_user_1, format: :js }
        expect(response.body).to eq({message: "You can`t vote for your Question"}.to_json)
      end
    end
  end

  describe 'PATCH #vote_cancel' do
    context 'User cansal vote for his voting'
    context 'User cansal vote for other user voting'
  end

  describe 'Private function votable' do
  end
end
