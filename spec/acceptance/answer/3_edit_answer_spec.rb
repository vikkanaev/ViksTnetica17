require_relative '../acceptance_helper'

feature 'Answer editing', %q{
  In order to fix my mistakes
  As an author of answer
  I want to be able to edit my answer
} do
  given!(:user_author) { create(:user) }
  given(:user_not_author) { create(:user) }
  given!(:question) { create(:question, user: user_author) }
  given!(:answer) { create(:answer, question: question, user: user_author) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end

  describe 'Authenticated user' do
    before do
      sign_in(user_author)
      visit question_path(question)
    end

    scenario 'sees Edit link' do
      expect(page).to have_link 'Edit'
    end

    scenario 'try to edit answer', js: true do
      visit question_path(question)

      click_on 'Edit Answer'

        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      
    end

    scenario "try to edit other user's question"
  end
end
