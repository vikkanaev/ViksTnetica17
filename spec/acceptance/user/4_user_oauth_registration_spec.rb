require_relative '../acceptance_helper'

feature 'GuestUser registration via social networks', '
  In order to be able ask questions
  As an GuestUser
  I want to be able to registre via social networks
  ' do

  scenario 'New User registre via Facebook' do
    visit new_user_registration_path
    expect(page).to have_content('Sign in with Facebook')
    mock_auth_hash
    click_link 'Sign in with Facebook'
    expect(page).to have_content('mockuser_facebook') # user name
  end

  scenario 'New User registre via Twitter' do
    visit new_user_registration_path
    expect(page).to have_content('Sign in with Twitter')
    mock_auth_hash
    click_link 'Sign in with Twitter'
    save_and_open_page
    expect(page).to have_content('please enter email') # user name
  end
end
