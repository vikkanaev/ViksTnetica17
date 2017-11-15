require_relative '../acceptance_helper'

feature 'Create answer from the question page', %q{
  In order to be able helps
  As an User
  I want to be able to create answer from the question page
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }


  scenario 'Authenticated user create answer if all fields is valid', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: 'Answer Body'
    click_on 'add file'
    click_on 'add file'
    inputs = all('input[type="file"]')
      inputs[0].set("#{Rails.root}/README.md")
      inputs[1].set("#{Rails.root}/spec/rails_helper.rb")

    wait_for_ajax
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'README.md', href: '/uploads/attachment/file/1/README.md'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end
end
