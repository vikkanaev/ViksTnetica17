require_relative '../acceptance_helper'

feature 'Authenticated user vote for question', %q{
  In order to find best question
  As an User
  I want to be able to vote for questions
} do
  given!(:user_1) { create(:user) }
  given!(:user_2) { create(:user) }
  given!(:question_1_user_1) { create(:question, user: user_1) }
  given!(:question_2_user_1) { create(:question, user: user_1) }
  given!(:question_1_user_2) { create(:question, user: user_2) }
  given!(:question_2_user_2) { create(:question, user: user_2) }

  scenario 'Authenticated user vote-up for question', js: true do
    sign_in(user_2)
    visit questions_path
    within '#question-1' do
      click_on 'Vote_up'
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to have_content 'Vote_cancel'
      expect(page).to have_content 'Question score 1'
    end
  end

  scenario 'Authenticated user vote-up for his question', js: true do
    sign_in(user_1)
    visit questions_path
    within '#question-1' do
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to_not have_content 'Vote_cancel'
    end
  end

  scenario 'Authenticated user vote-down for question', js: true do
    sign_in(user_2)
    visit questions_path
    within '#question-1' do
      click_on 'Vote_down'
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to have_content 'Vote_cancel'
      expect(page).to have_content 'Question score -1'
    end
  end

  scenario 'Authenticated user vote-down for his question', js: true do
    sign_in(user_1)
    visit questions_path
    within '#question-1' do
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to_not have_content 'Vote_cancel'
    end
  end

  scenario 'Authenticated user cancel vote for his question', js: true do
    sign_in(user_2)
    visit questions_path
    within '#question-1' do
      click_on 'Vote_down'
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to have_content 'Vote_cancel'
      expect(page).to have_content 'Question score -1'

      click_on 'Vote_cancel'
      expect(page).to have_content 'Vote_up'
      expect(page).to have_content 'Vote_down'
      expect(page).to_not have_content 'Vote_cancel'
      expect(page).to have_content 'Question score 0'
    end
  end
end
