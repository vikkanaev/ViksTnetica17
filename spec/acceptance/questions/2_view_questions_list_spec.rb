require 'rails_helper'

feature 'View the list of questions', %q{
  In order to be able find the answer
  As an User
  I want to be able to view the list of questions
} do
  given!(:user_author) { create(:user) }
  given!(:questions) { create_list(:question, 6) }
  given!(:one_question) { create(:question) }

  # не нашел пока как обернуть нестед вопрос в create_list
  before do
    @answers = Array.new
    5.times { @answers << create(:answer, question: one_question, user: user_author)  }
  end

  scenario 'User view the list of questions' do
    visit questions_path
    questions.each do |q|
      expect(page).to have_content q.title
    end
  end

  scenario 'User can view question and answers' do
    visit question_path(one_question)
    @answers.each do |a|
      expect(page).to have_content a.body
    end
  end
end
