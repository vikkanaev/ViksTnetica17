require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:user_author) { create(:user) }
  let!(:question) { create(:question, user: user_author) }
  let!(:best_answer) { create(:answer, question: question, user: user_author, best: true) }
  let!(:some_answer) { create(:answer, question: question, user: user_author, best: false) }

  it { should belong_to(:question) }

  it 'validate_presence_of(:body)' do
    best_answer.should validate_presence_of(:body)
  end

  it 'Validate for uniq best answer' do
    question.answers.new(body: '321', best: true)
    question.answers.last.valid?
    expect(question.answers.last.errors.full_messages[0]).to eq('There can be only one best answer!')
  end

  describe 'public model methods' do
    before do
      question.answers.find(some_answer).set_best
      question.reload
    end

    context 'Set_best'
      it 'mark all answers as not best' do
        expect(question.answers.where(best: false).ids[0]).to eq best_answer.id
      end

      it 'set this answer as best' do
        expect(question.answers.where(best: true).ids[0]).to eq some_answer.id
    end
  end
end
