require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  describe 'public model methods' do
    let!(:user_author) { create(:user) }
    let!(:question) { create(:question, user: user_author) }
    let!(:answer) { create(:answer, question: question, user: user_author) }

    it 'Set_best_answer' do
      question.set_best_answer(answer)
      expect(question.best_answer).to eq answer.id
    end

    it 'UnSet_best_answer' do
      question.unset_best_answer
      expect(question.best_answer).to eq nil
    end
  end
end
