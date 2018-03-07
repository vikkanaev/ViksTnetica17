require 'rails_helper'

RSpec.describe QuestionMailer, type: :mailer do
  describe 'new_answer' do
    let(:author) { create(:user) }
    let(:some_user) { create(:user) }
    let(:question) { create(:question, user: author) }
    let(:answer) { create(:answer, question: question, user: some_user) }
    let(:subscription) { create(:subscription, question: question, user: author) }
    let(:mail) { QuestionMailer.new_answer(answer, author) }

    before { answer }
    it 'renders the headers' do
      expect(mail.subject).to eq('New answer')
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'send email to subscribed user' do
      expect(mail.to).to eq([author.email])
    end

    it 'not send email to answer user' do
      expect(mail.to).to_not eq([some_user.email])
    end

    it 'renders the Answer link' do
      expect(mail.body.encoded).to match(url_for(answer))
    end

    it 'renders the Questions title' do
      expect(mail.body.encoded).to match(question.title)
    end
  end
end
