class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gon_question_id, only: [:index, :show]
  before_action :build_answer, only: :show
  before_action :build_question, only: :index
  before_action :load_all_questions, only: [:create, :update, :destroy]

  after_action :publish_question, only: [:create]

  respond_to :json, :js

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.delete) if current_user.author_of?(@question)
  end

  private

  def load_all_questions
    @questions = Question.all
  end

  def build_question
    @question = Question.new
  end

  def build_answer
    @answer = @question.answers.build
  end

  def set_gon_question_id
    gon.question_id = params[:id]
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
        question: ApplicationController.render(
          partial: 'questions/question_channel',
          locals: { question: @question }
      )
    )
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end
end
