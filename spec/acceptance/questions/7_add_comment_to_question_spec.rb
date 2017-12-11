require_relative '../acceptance_helper'

feature 'Create comment', %q{
  In order to comunicate with another user
  As an User
  I want to be able to create comment to question
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user create comment', js: true do
    sign_in(user)
    visit question_path(question)
      click_on 'add a comment'

      fill_in "Message", with: 'My comment body'
      click_on 'Save comment'

    expect(page).to have_content 'Your comment successfully created.'
    expect(page).to have_content 'My comment body'
  end

  context "muliple sessions" do
    scenario "Authenticated user create comment", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end
      Capybara.using_session('guest') do
        visit question_path(question)
      end
      Capybara.using_session('user') do
        click_on 'add a comment'

        fill_in 'Message', with: 'My comment body'
        click_on 'Save comment'

        expect(page).to have_content 'Your comment successfully created.'
        expect(page).to have_content 'My comment body'
      end
      Capybara.using_session('guest') do
        expect(page).to have_content 'My comment body'
      end

    end
  end
end
