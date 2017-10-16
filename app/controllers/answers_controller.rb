class AnswersController < ApplicationController
  before_action :find_question, only: [:create]
  before_action :find_answer, only: [:destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  def destroy
    @question = Question.find(@answer.question_id)
    @answer.destroy
    flash[:notice] = 'Your answer successfully deleted.'
    redirect_to @question
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end
