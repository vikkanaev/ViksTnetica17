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

  scenario 'Question not created if not all fields is valid' do
    sign_in(user)

    visit new_question_path
    click_on 'Create'

    expect(page).to have_content 'All fields are required!'
  end
end
