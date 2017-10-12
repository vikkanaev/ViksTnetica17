require 'rails_helper'

# Пользователь может войти в систему
feature 'User login', %q{
  In order to be able ask questions
  As an User
  I want to be able to login
} do
  scenario 'Registred user try to login' do
    User.create!(email: 'test@test.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
#    save_and_open_page
    click_on 'Log in'

    expect(page).to have_content 'Signed in'
    expect(current_path).to eq root_path
  end

  scenario 'UnRegisterd user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
    expect(current_path).to eq new_user_session_path
  end

  # Пользователь может выйти из системы
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

    # Пользователь может зарегистрироваться в системе
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
          #save_and_open_page
          click_on 'Sign up!'

          expect(page).to have_content 'You have signed up successfully.'
          expect(current_path).to eq root_path
        end
        scenario 'Invalid email and password' do
          visit new_user_registration_path
          fill_in 'Email', with: 'test@test.com'
          fill_in 'Password', with: '12345678'
          #save_and_open_page
          click_on 'Sign up!'

          expect(page).to have_content 'error prohibited this user from being saved'
          expect(current_path).to eq user_registration_path
        end
      end
end
