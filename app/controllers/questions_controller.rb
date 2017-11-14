class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.all
    @question = Question.new
    @question.attachments.build
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def new
    @question = Question.new
  end

  def create
    @questions = Question.all
    @question = current_user.questions.build(question_params)
    if @question.save
      flash.now[:notice] = 'Your question successfully created.'
    end
  end

  def update
    @question.update(question_params)
    @questions = Question.all
  end

  def destroy
    @questions = Question.all
    if current_user.author_of?(@question) && @question.destroy
      flash.now[:notice] = 'Your question successfully deleted.'
    else
      flash.now[:notice] = 'You can not delete this question'
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end
end
