class AnswersController < ApplicationController
  before_action :find_question, only: [:create]
  before_action :find_answer, only: [:destroy, :update, :set_best_answer_ever]
  before_action :authenticate_user!
  before_action :load_all_answers, only: :set_best_answer_ever

  after_action :publish_answer, only: [:create]


  respond_to :json, :js

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user_id: current_user.id)))
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
  end

  def destroy
    respond_with(@answer.destroy) if current_user.author_of?(@answer)
  end

  def set_best_answer_ever
     respond_with(@question.answers.find(params[:id]).set_best) if current_user.author_of?(@question)
  end

  private

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "questions/#{@question.id}/answers",
        answer: ApplicationController.render(
          partial: 'questions/answer_channel',
          locals: { answer: @answer }
      )
    )
  end

  def load_all_answers
    @answers = @question.answers
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end
end
