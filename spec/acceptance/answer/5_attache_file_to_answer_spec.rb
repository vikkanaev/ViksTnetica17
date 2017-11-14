require_relative '../acceptance_helper'

feature 'Create answer from the question page', %q{
  In order to be able helps
  As an User
  I want to be able to create answer from the question page
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  #given(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user create answer if all fields is valid' #, js: true do
#    sign_in(user)
#    visit question_path(question)
#    fill_in 'Body', with: answer.body
#    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
#
#    click_on 'Create Answer'
#    within '.answers' do
#      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
#    end
#  end
end
