require_relative '../acceptance_helper'

feature 'Create answer from the question page', %q{
  In order to be able helps
  As an User
  I want to be able to create answer from the question page
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user create answer if all fields is valid', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: answer.body

    click_on 'Create Answer'
    expect(page).to have_content 'Answer was successfully created.'
    expect(page).to have_content answer.body
  end

  scenario 'Guest user cant create answer.', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Create Answer'
  end

  scenario 'Authenticated user cant create answer not all fields is valid', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Create Answer'

    expect(page).to have_content "Body can't be blank"
    expect(page).to_not have_content answer.body
  end

  context "muliple sessions" do
    scenario "answer appears on other users page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end
      Capybara.using_session('guest') do
        visit question_path(question)
      end
      Capybara.using_session('user') do
        fill_in 'Body', with: 'Tell me why why why'
        click_on 'Create Answer'
        expect(page).to have_content 'Answer was successfully created.'
        expect(page).to have_content 'Tell me why why why'
      end
      Capybara.using_session('guest') do
        expect(page).to have_content 'Tell me why why why'
      end

    end
  end
end
