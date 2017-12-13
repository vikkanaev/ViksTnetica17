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
        expect(page).to have_content "This is best answer ever!"
      end
    end

    scenario 'Best answer showing first', js: true do
      visit question_path(question)
      within "#answer-2" do
        click_on 'Chois as Best'
      end
      wait_for_ajax
      within ".answers" do
        expect(page.first("p").text).to have_content best_answer.body
      end
    end

    scenario 'Autor can re-choise another answer as best', js: true do
      within "#answer-#{best_answer.id}" do
        click_on 'Chois as Best'
      end
      within "#answer-#{answer.id}" do
        click_on 'Chois as Best'
        wait_for_ajax
        expect(page).to have_content "This is best answer ever!"
      end
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

  describe 'Not Authenticated user', js: true  do
    before do
      sign_in(user_author)
      visit question_path(question)
      within "#answer-#{best_answer.id}" do
        click_on 'Chois as Best'
      end
      visit user_session_path
      click_on 'Logout'
    end

    scenario 'Best answer showing first' do
      visit question_path(question)
      within ".answers" do
        expect(page.first("p").text).to have_content best_answer.body
      end
    end

  end # End describe 'Not Authenticated user'
end
