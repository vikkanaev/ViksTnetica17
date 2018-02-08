require_relative '../acceptance_helper'

feature 'Authenticated user vote for question', %q{
  In order to find best question
  As an User
  I want to be able to vote for questions
} do
  given!(:user_1) { create(:user) }
  given!(:user_2) { create(:user) }
  given!(:question_1_user_1) { create(:question, user: user_1) }
  given!(:question_2_user_1) { create(:question, user: user_1) }
  given!(:question_1_user_2) { create(:question, user: user_2) }
  given!(:question_2_user_2) { create(:question, user: user_2) }
  given!(:vote_obj) { 'question' }

  it_behaves_like 'Votable'

  def visit_page
    visit questions_path
  end
end
