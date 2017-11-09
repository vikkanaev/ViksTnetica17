require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

#  describe 'Custom validation test' do
#    let!(:user_author) { create(:user) }
#    let!(:question) { create(:question, user: user_author) }
#    let!(:best_answer) { create(:answer, question: question, user: user_author, best: true) }
#    let!(:some_answer) { create(:answer, question: question, user: user_author, best: true) }
#
#    it 'Validate for uniq best answer' do
#      question.answers.find(some_answer).set_best
#      question.valid?
#      binding.pry
#      expect(question.answers.last.errors.full_messages[0]).to eq('There can be only one best answer!')
#    end
#  end

end
