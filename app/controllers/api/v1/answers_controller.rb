class Api::V1::AnswersController < Api::V1::BaseController
  authorize_resource
  before_action :find_question, only: :index
  def index
    @answers = @question.answers
    respond_with @answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def create
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end
