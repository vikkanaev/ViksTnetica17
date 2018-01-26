require 'rails_helper'

describe Ability do # rubocop:disable Metrics/BlockLength
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do # rubocop:disable Metrics/BlockLength
    let(:user) { create :user }
    let(:other_user) { create :user }
    let(:question) { create(:question, user: user) }
    let(:other_question) { create(:question, user: other_user) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    describe 'create' do
      it { should be_able_to :create, Question }
      it { should be_able_to :create, Answer }
      it { should be_able_to :create, Comment }
      it { should be_able_to :create, Attachment }
    end

    describe 'update' do
      it { should be_able_to :update, create(:question, user: user), user: user }
      it { should_not be_able_to :update, create(:question, user: other_user), user: user }
      it { should be_able_to :update, create(:answer, user: user), user: user }
      it { should_not be_able_to :update, create(:answer, user: other_user), user: user }
      it { should be_able_to :update, create(:comment, user_id: user.id), user: user }
      it { should_not be_able_to :update, create(:comment, user_id: other_user), user: user }
    end

    describe 'destroy' do
      it { should be_able_to :destroy, create(:question, user: user), user: user }
      it { should_not be_able_to :destroy, create(:question, user: other_user), user: user }
      it { should be_able_to :destroy, create(:answer, user: user), user: user }
      it { should_not be_able_to :destroy, create(:answer, user: other_user), user: user }
      it { should be_able_to :destroy, create(:comment, user_id: user.id), user: user }
      it { should_not be_able_to :destroy, create(:comment, user_id: other_user), user: user }
      it { should be_able_to :destroy, create(:attachment, attachmentable: question), user: user }
      it { should_not be_able_to :destroy, create(:attachment, attachmentable: other_question), user: user }
    end

    describe 'set_best' do
      it { should be_able_to :set_best_answer_ever, create(:answer, question: question), user: user }
      it { should_not be_able_to :set_best_answer_ever, create(:answer, question: other_question), user: user }
    end

    describe 'vote' do
      it { should be_able_to :destroy, create(:vote, votable: other_question, user: user), user: user }
      it { should_not be_able_to :destroy, create(:vote, votable: other_question, user: other_user), user: user }

      describe 'vote_up' do
        it { should be_able_to :vote_up, other_question, user: user }
        it { should_not be_able_to :vote_up, question, user: user }
      end

      describe 'vote_down' do
        it { should be_able_to :vote_down, other_question, user: user }
        it { should_not be_able_to :vote_down, question, user: user }
      end

      describe 'vote_cancel' do
        it 'by owner' do
          other_question.vote_up(user)
          should be_able_to :vote_cancel, other_question, user: user
        end

        it { should_not be_able_to :vote_cancal, create(:vote, votable: question, user: other_user), user: user }
      end
    end
  end
end
