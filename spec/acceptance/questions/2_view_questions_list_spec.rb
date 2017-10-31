require_relative '../acceptance_helper'

feature 'View the list of questions', %q{
  In order to be able find the answer
  As an User
  I want to be able to view the list of questions
} do
  let!(:user_author) { create(:user) }
  let!(:questions) { create_list(:question, 6, user: user_author) }
  given!(:one_question) { create(:question) }
  let!(:answers) { create_list(:answer, 5, question: one_question, user: user_author) }

  scenario 'User view the list of questions' do
    visit questions_path
    
    questions.each do |q|
      expect(page).to have_content q.title
    end
  end

  scenario 'User can view question and answers' do
    visit question_path(one_question)
    answers.each do |a|
      expect(page).to have_content a.body
    end
  end
end
