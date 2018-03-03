require 'rails_helper'

RSpec.describe DailyMailer, type: :mailer do
  describe 'digest' do
    let(:user) { create(:user) }
    let!(:questions) { create_list(:question, 2, user: user) }
    let!(:old_questions) { create_list(:question, 2, user: user, created_at: Date.yesterday) }
    let(:mail) { DailyMailer.digest(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Digest')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the new questions titles' do
      expect(mail.body.encoded).to match(questions.last.title)
      expect(mail.body.encoded).to match(questions.first.title)
    end

    it 'not renders old questions titles' do
      expect(mail.body.encoded).to_not match(old_questions.last.title)
      expect(mail.body.encoded).to_not match(old_questions.first.title)
    end
  end
end
