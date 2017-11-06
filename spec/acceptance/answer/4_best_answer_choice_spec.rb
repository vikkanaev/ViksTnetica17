require_relative '../acceptance_helper'

feature 'Best answer choice ', %q{
  In order to encourage the author of the answer
  As the author of the question
  I want to choose the best answer
} do
  given!(:user_author) { create(:user) }
  given(:user_not_author) { create(:user) }
  given!(:question) { create(:question, user: user_author) }
  given!(:answer) { create(:answer, question: question, user: user_author) }
  given!(:best_answer) { create(:answer, question: question, user: user_author) }

  describe 'Authenticated user - Author' do
    before do
      sign_in(user_author)
      visit question_path(question)
    end

    scenario 'Author see Chois as Best link' do
      expect(page).to have_link 'Chois as Best'
    end

    scenario 'Author can choise best answer', js: true do
      within "#answer-#{best_answer.id}" do
        click_on 'Chois as Best'
      end
      expect(page).to have_content "Set answer #{best_answer.id} as best answer ever!"
    end

    scenario 'Autor can re-choise another answer as best', js: true do
      within "#answer-#{best_answer.id}" do
        click_on 'Chois as Best'
      end
      within "#answer-#{answer.id}" do
        click_on 'Chois as Best'
      end
      expect(page).to have_content "Set answer #{answer.id} as best answer ever!"
    end
  end # End for describe 'Authenticated user'

  describe 'Authenticated user - Not Author' do
    before do
      sign_in(user_not_author)
      visit question_path(question)
    end

    scenario 'Not Author not see Chois as Best link' do
      expect(page).to_not have_link 'Chois as Best'
    end
  end # describe 'Authenticated user - Not Author'

  describe 'Not Authenticated user' do
    before { visit question_path(question) }

    scenario 'Best answer showing first'
  end # End describe 'Not Authenticated user'
end
