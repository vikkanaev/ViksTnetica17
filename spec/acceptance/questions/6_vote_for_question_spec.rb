require_relative '../acceptance_helper'

feature 'Authenticated user vote for question', %q{
  In order to find best question
  As an User
  I want to be able to vote for questions
} do
  given!(:user) { create(:user) }

  scenario 'Authenticated user vote for question' #do
#    sign_in(user)
#    visit questions_path
#    click_on 'Vote for Question'
#
#    expect(page).to have_content 'Your vote was counted'
#  end
end
