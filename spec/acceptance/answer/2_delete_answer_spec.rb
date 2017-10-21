require 'rails_helper'

feature 'Delete answer from the question page', %q{
  In order to fix my mistakes
  As an User
  I want to be able to delete my answer from the question page
} do
  given!(:user_author) { create(:user) }
  given!(:user_not_author) { create(:user) }
  given!(:question) { create(:question, user: user_author) }
  given!(:answer) { create(:answer, question: question, user: user_author) }

  scenario 'User can delete his answers' do
    sign_in(user_author)
    visit question_path(question)
    click_on 'Delete Answer'

    expect(page).to have_content 'Your answer successfully deleted'
    expect(page).to_not have_content answer.body
  end

  scenario 'User can not delete other users answers' do
    sign_in(user_not_author)
    visit question_path(question)

    expect(page).to_not have_content 'Delete Answer'
  end

  scenario 'Guset user can not delete other users answers' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete Answer'
  end
end
