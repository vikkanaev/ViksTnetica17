require 'rails_helper'

feature 'Create answer from the question page', %q{
  In order to be able helps
  As an User
  I want to be able to create answer from the question page
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer if all fields is valid' do
    sign_in(user)
    visit question_path(question)
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body

    click_on 'Create Answer'

    expect(page).to have_content 'Your answer successfully created.'
  end

  scenario 'Guest user cant create answer.' do
    visit question_path(question)
    expect(page).to have_content 'You need to sign in or sign up before commenting'
  end

  scenario 'Authenticated user cant create answer not all fields is valid' do
    sign_in(user)
    visit question_path(question)
    click_on 'Create Answer'

    expect(page).to have_content 'All fields are required in Answer!'
  end
end

# Автор может удалить свой ответ, но не может удалить чужой ответ
feature 'Delete answer from the question page', %q{
  In order to fix my mistakes
  As an User
  I want to be able to delete my answer from the question page
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'User can delete his answers' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete Answer'
    #find_link('Delete Answer').click

    expect(page).to have_content 'Your answer successfully deleted.'
  end
  scenario 'User can not delete other users answers'
end
