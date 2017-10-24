require_relative '../acceptance_helper'

feature 'User logout', %q{
  In order to be able not ask questions anymore
  As an User
  I want to be able to logout
  } do
    scenario 'Signedin user try to logout' do
      User.create!(email: 'test@test.com', password: '12345678')

      visit new_user_session_path
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'
      click_on 'Logout'

      expect(page).to have_content 'Signed out successfully.'
      expect(current_path).to eq root_path
    end

    scenario 'Not Signedin user try to login' do
      visit '/'

      expect(page).to_not have_content 'Logout'
    end
  end
