require_relative '../acceptance_helper'

feature 'Subscribe/Unsubscribe to Question', %q{
  In order to know about new answers
  As an Registred User
  I want to be able to subscribe/unsubscribe to new answers for question
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user subscribe and unsubscribe to new answers', js: true do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_link 'Subscribe'
    expect(page).to_not have_link 'Unsubscribe'
    click_on 'Subscribe'
    expect(page).to have_link 'Unsubscribe'
    expect(page).to_not have_link'Subscribe'
  end

  scenario 'Guest user can not subscribe and unsubscribe to new answers', js: true do
    visit question_path(question)
    expect(page).to_not have_link'Subscribe'
    expect(page).to_not have_link 'Unsubscribe'
  end
end
