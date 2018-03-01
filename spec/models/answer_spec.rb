require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:user_author) { create(:user) }
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

  describe 'reputation' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    subject { build(:answer, user: user, question: question) }

    it 'should calculate reputation after creating' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'should not calculate reputation after update' do
      subject.save!
      expect(Reputation).to_not receive(:calculate)
      subject.update(body: '123')
    end
  end
end
