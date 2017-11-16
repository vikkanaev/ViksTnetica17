require_relative '../acceptance_helper'

feature 'Authenticated user delete files on his question', %q{
  In order to be
  As an User
  I want to be able to delete attachments to questions
} do
  given!(:user) { create(:user) }
  given!(:user_not_author) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:attachment) { create(:attachment, attachmentable: question) }

  scenario 'Authenticated user delete attach file', js: true do
    sign_in(user)
    visit questions_path
    fill_in 'Title', with: 'Question Title'
    fill_in 'Body', with: 'Question Body'
    click_on 'add file'
    click_on 'add file'
    inputs = all('input[type="file"]')
      inputs[0].set("#{Rails.root}/README.md")
      inputs[1].set("#{Rails.root}/spec/rails_helper.rb")

    wait_for_ajax
    click_on 'Create'
    click_on 'Question Title'
    within '#attachment-1' do
      click_on 'Delete'
    end
    wait_for_ajax
    within '.question' do
      expect(page).to_not have_link 'README.md', href: '/uploads/attachment/file/1/README.md'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end

  describe 'Authenticated user ' do
    before { create(:attachment) }

    scenario 'can not delete other user files', js: true do
      attachment
      sign_in(user_not_author)
      visit question_path(question)
      within '.attachments' do
        expect(page).to_not have_link 'Delete'
      end
    end
  end
end
