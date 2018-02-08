require_relative '../acceptance_helper'

feature 'Authenticated user vote for question', %q{
  In order to find best question
  As an User
  I want to be able to vote for questions
} do
  given!(:user_1) { create(:user) }
  given!(:user_2) { create(:user) }
  given!(:question) { create(:question, user: user_1) }
  given!(:answer_1_user_1) { create(:answer, question: question, user: user_1) }
  given!(:answer_2_user_1) { create(:answer, question: question, user: user_1) }
  given!(:answer_1_user_2) { create(:answer, question: question, user: user_2) }
  given!(:answer_2_user_2) { create(:answer, question: question, user: user_2) }
  given!(:vote_obj) { 'answer' }

  it_behaves_like 'Votable'

  def visit_page
    visit question_path(question)
  end
end
