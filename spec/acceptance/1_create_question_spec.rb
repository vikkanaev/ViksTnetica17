require 'rails_helper'

feature 'Create question', %q{
  In order to be able find the answer
  As an User
  I want to be able to create question
} do
  scenario 'Question created if all fields is valid' do
    visit new_question_path
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Long long story!'
    click_on 'Create'

    expect(page).to have_content 'Long long story'
  end

  scenario 'Question not created if not all fields is valid' do
    visit new_question_path
    click_on 'Create'

    expect(page).to have_content 'All fields are required!'
  end
end
