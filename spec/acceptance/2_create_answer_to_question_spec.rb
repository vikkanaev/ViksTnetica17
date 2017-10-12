require 'rails_helper'

feature 'Create answer from the question page', %q{
  In order to be able helps
  As an User
  I want to be able to create answer from the question page
} do
  scenario 'Answer created if all fields is valid' do
    @question = create(:question)
    visit question_path(@question)
    fill_in 'Title', with: 'Test answer title'
    fill_in 'Body', with: 'Long long answer!'

    click_on 'Create Answer'

    expect(page).to have_content 'Long long answer!'
  end

  scenario 'Answer not created if not all fields is valid' do
    @question = create(:question)
    visit question_path(@question)
    click_on 'Create Answer'

    expect(page).to have_content 'All fields are required in Answer!'
  end
end
