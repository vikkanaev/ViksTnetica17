# NOTE: вернуть поиск

# require_relative 'acceptance_helper'
# feature 'Search smth', %q{
# User can search
# } do
#
#   given!(:user) { create(:user, email: 'ask@test.com') }
#   given(:other_user) { create(:user) }
#   given!(:question) { create(:question, title: 'ask') }
#   given!(:answer) { create(:answer, body: 'ask') }
#   given!(:comment) { create(:comment, user_id: other_user.id, commentable: question, message: 'ask') }
#
#   %w[Answers Questions Comments Users].each do |attr|
#     scenario "User can search in #{attr}", js: true do
#       ThinkingSphinx::Test.run do
#         visit root_path
#         expect(page).to have_button 'Search'
#         select(attr, from: 'search_area')
#         fill_in 'search_string', with: 'ask'
#         click_on 'Search'
#         expect(page).to have_content attr.singularize
#       end
#     end
#   end
#
#   scenario 'User can search everywhere', js: true do
#     ThinkingSphinx::Test.run do
#       visit root_path
#       expect(page).to have_button 'Search'
#       select('Everywhere', from: 'search_area')
#       fill_in 'search_string', with: 'ask'
#       click_on 'Search'
#       expect(page).to have_content 'Question'
#       expect(page).to have_content 'Answer'
#       expect(page).to have_content 'Comment'
#       expect(page).to have_content 'User'
#     end
#   end
# end
