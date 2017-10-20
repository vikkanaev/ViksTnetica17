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
    create_question

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Guest user cant create question.' do
    visit questions_path
    click_on 'Create new question'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  scenario 'Question not created with invalid data' do
    sign_in(user)
    visit questions_path
    click_on 'Create new question'
    fill_in 'Title', with: question.title
    click_on 'Create'

    expect(page).to have_content "Body can't be blank"
  end
end
