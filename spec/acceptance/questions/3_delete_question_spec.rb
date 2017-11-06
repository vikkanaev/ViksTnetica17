require_relative '../acceptance_helper'

feature 'Delete question', %q{
  In order to fix my mistakes
  As an User
  I want to be able to delete my question from the question page
} do
  given!(:user_author) { create(:user) }
  given!(:user_not_author) { create(:user) }
  given!(:question) { create(:question, user: user_author) }

  scenario 'User can delete his question from the questions index page', js: true do
    sign_in(user_author)
    visit questions_path
    click_on 'Delete Question'

    expect(page).to have_content 'Your question successfully deleted.'
    expect(page).to_not have_content question.body
  end

  scenario 'User can not delete other users questions' do
    sign_in(user_not_author)
    visit question_path(question)

    expect(page).to_not have_content 'Delete Question'
    expect(page).to have_content question.body
  end

  scenario 'Guest User can not delete other users questions' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete Question'
    expect(page).to have_content question.body
  end
end
