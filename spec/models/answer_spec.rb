require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should validate_presence_of(:body) }

  describe 'public model methods' do
    let!(:user_author) { create(:user) }
    let!(:question) { create(:question, user: user_author) }
    let!(:best_answer) { create(:answer, question: question, user: user_author) }
    let!(:worst_answer) { create(:answer, question: question, user: user_author) }

    before { question.best_answer = best_answer.id }

    context 'Return True if answer is best' do
      it { expect(best_answer.is_best?).to be(true) }
    end
    context 'Return False if answer is not best' do
      it { expect(worst_answer.is_best?).to be(false) }
    end
  end
end
