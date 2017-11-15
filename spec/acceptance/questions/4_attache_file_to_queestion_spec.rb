require_relative '../acceptance_helper'

feature 'Create question from the questions page', %q{
  In order to be able helps
  As an User
  I want to be able to create question with files from the questions page
} do
  given!(:user) { create(:user) }

  scenario 'Authenticated user create question and attach file', js: true do
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
    
    within '.question' do
      expect(page).to have_link 'README.md', href: '/uploads/attachment/file/1/README.md'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end
end
