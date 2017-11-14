require_relative '../acceptance_helper'

feature 'Create answer from the question page', %q{
  In order to be able helps
  As an User
  I want to be able to create answer from the question page
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  before do
  end

  scenario 'Attached file dont show in new_question form after create question' #, js: true do
#    sign_in(user)
#    visit questions_path
#    fill_in 'Title', with: question.title
#    fill_in 'Body', with: question.body
#    attach_file 'File', "#{Rails.root}/README.md"
#
#    click_on 'Create'
#
#    wait_for_ajax
#    save_and_open_page
#    within '.new_question' do
#      expect(page).to_not have_content 'README.md'
#    end
#  end

  scenario 'Authenticated user create question and attach file' #, js: true do
#    sign_in(user)
#    visit questions_path
#    fill_in 'Title', with: question.title
#    fill_in 'Body', with: question.body
#    attach_file 'File', "#{Rails.root}/README.md"
#
#    click_on 'Create'
#
#    wait_for_ajax
#
#    visit question_path(question)
#    save_and_open_page
#    within '.question' do
#      expect(page).to have_link 'README.md', href: '/uploads/attachment/file/1/README.md'
#    end
#  end
end
