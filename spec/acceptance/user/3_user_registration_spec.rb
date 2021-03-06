require_relative '../acceptance_helper'

feature 'GuestUser registration', %q{
  In order to be able ask questions
  As an GuestUser
  I want to be able to registre
  } do
    scenario 'Valid email and password' do
      visit new_user_registration_path
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up!'
      expect(page).to have_content 'You have signed up successfully.'
      expect(current_path).to eq root_path
    end

    scenario 'Invalid email and password' do
      visit new_user_registration_path
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '12345678'
      click_on 'Sign up!'
      expect(page).to have_content 'error prohibited this user from being saved'
      expect(current_path).to eq user_registration_path
    end
  end
