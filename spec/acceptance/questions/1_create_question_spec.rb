require_relative '../acceptance_helper'

feature 'Create question', %q{
  In order to be able find the answer
  As an User
  I want to be able to create question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create valid question', js: true do
    sign_in(user)
    create_question

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content question.title
  end

  scenario 'Guest user cant create question.', js: true do
    visit questions_path

    expect(page).to_not have_content 'Ask your question if you want'
    expect(page).to_not have_link 'Create'
  end

  scenario 'Question not created with invalid data', js: true do
    sign_in(user)
    visit questions_path
    fill_in 'Title', with: question.title
    click_on 'Create'

    expect(page).to have_content "Body can't be blank"
  end

  context "muliple sessions" do
    scenario "question appears on other users page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end
      Capybara.using_session('guest') do
        visit questions_path
      end
      Capybara.using_session('user') do
        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'Tell me why why why'
        click_on 'Create'
        expect(page).to have_content 'Your question successfully created.'
        expect(page).to have_content 'Test question'
      end
      Capybara.using_session('guest') do
        expect(page).to have_content 'Test question'
      end

    end
  end
end
