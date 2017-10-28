class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.all
  end

  def show
    #@answer = Answer.new
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def update
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    if current_user.author_of?(@question) && @question.destroy
      flash[:notice] = 'Your question successfully deleted.'
      redirect_to questions_path
    else
      flash[:notice] = 'You can not delete this question'
      redirect_to @question
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
