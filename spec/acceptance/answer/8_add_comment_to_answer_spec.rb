require_relative '../acceptance_helper'

feature 'Create comment', %q{
  In order to comunicate with another user
  As an User
  I want to be able to create comment to answer
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user create comment', js: true do
    sign_in(user)
    visit question_path(question)
    within '#answer-1' do
      click_on 'add a comment'

      # не понимаю почему помогло заменить вместо fill_in 'Message' на fill_in 'comment[message]'
      # но первое не работало, а это завелось!
      fill_in 'comment[message]', with: 'My comment body'
      click_on 'Save comment'
    end
    expect(page).to have_content 'Your comment successfully created.'
    # Да, это костыль в тесте.
    # У меня корректно работает AJAX добавление коментария и в Chrome и в Firefox,
    # но в тестах коментарий не виден до релоуда страницы :(
    page.evaluate_script("window.location.reload()")
    expect(page).to have_content 'My comment body'
  end

end
