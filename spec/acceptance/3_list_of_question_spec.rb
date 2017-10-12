require 'rails_helper'

feature 'View the list of questions', %q{
  In order to be able find the answer
  As an User
  I want to be able to view the list of questions
} do
  scenario 'User view the list of questions' do
    Question.create(title: 'Title1', body: 'Long long story1')
    Question.create(title: 'Title2', body: 'Long long story2')
    visit questions_path

    expect(page).to have_content 'Long long story2'
  end

  scenario 'User can view question and answers' do
    @question = create(:question)
    @question.answers.create(title: 'Answer1', body: 'MyAnswerText')
    visit question_path(@question)

    expect(page).to have_content 'MyAnswerText'
  end
end
