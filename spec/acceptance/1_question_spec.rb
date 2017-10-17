require 'rails_helper'

feature 'Create question', %q{
  In order to be able find the answer
  As an User
  I want to be able to create question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create valid question' do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Guest user cant create question.' do
    visit new_question_path

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  scenario 'Question not created if not all fields is valid' do
    sign_in(user)

    visit new_question_path
    click_on 'Create'

    expect(page).to have_content 'All fields are required!'
  end
end

feature 'View the list of questions', %q{
  In order to be able find the answer
  As an User
  I want to be able to view the list of questions
} do

  scenario 'User view the list of questions' do
    # TODO Refactor Question creation with FactoryGirl pls
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

# Автор может удалить свой вопрос, но не может удалить чужой вопрос
feature 'Delete question from the question page', %q{
  In order to fix my mistakes
  As an User
  I want to be able to delete my question from the question page
} do
  given!(:user_author) { create(:user) }
  given!(:user_not_author) { create(:user) }
  given!(:question) { create(:question, user: user_author) }
  given!(:answer) { create(:answer, question: question, user: user_author) }

  scenario 'User can delete his question' do
    sign_in(user_author)
    visit question_path(question)
    click_on 'Delete Question'

    expect(page).to have_content 'Your question successfully deleted'
  end
  scenario 'User can not delete other users questions' do
    sign_in(user_not_author)
    visit question_path(question)
    click_on 'Delete Question'

    expect(page).to have_content 'You can not delete this question'
  end
end
