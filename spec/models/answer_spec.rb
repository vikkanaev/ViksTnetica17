require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:user_author) { create(:user) }
  let(:some_user) { create(:user) }
  let!(:question) { create(:question, user: user_author) }
  let!(:best_answer) { create(:answer, question: question, user: user_author, best: true) }
  let!(:some_answer) { create(:answer, question: question, user: user_author, best: false) }

  it { should belong_to(:question) }
  it { should have_many :attachments }
  it { should have_many(:comments).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }

  it_behaves_like 'votable'

  it 'validate_presence_of(:body)' do
    best_answer.should validate_presence_of(:body)
  end

  it 'Validate for uniq best answer' do
    question.answers.new(body: '321', best: true)
    question.answers.last.valid?
    expect(question.answers.last.errors.full_messages[0]).to eq('There can be only one best answer!')
  end

  describe 'Set_best method' do
    before do
      question.answers.find(some_answer.id).set_best
    end

    it 'mark all answers as not best' do
      expect(question.answers.where(best: false).first).to eq best_answer
    end

    it 'set this answer as best' do
      expect(question.answers.where(best: true).first).to eq some_answer
    end
  end

  it 'dont send email then author create new answer' do
    expect { create(:answer, question: question, user: user_author, best: false) }.to_not change { ActionMailer::Base.deliveries.count }
  end

  it 'send email then other user create new answer' do
    expect { create(:answer, question: question, user: some_user, best: false) }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
