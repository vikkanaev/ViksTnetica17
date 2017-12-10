class AnswersController < ApplicationController
  before_action :find_question, only: [:create]
  before_action :find_answer, only: [:destroy, :update, :set_best_answer_ever]
  before_action :authenticate_user!
  after_action :publish_answer, only: [:create]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    if @answer.save
      @comment = @answer.comments.build
      flash[:notice] = 'Your answer successfully created.'
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
    @comment = @answer.comments.build
  end

  def destroy
    @question = @answer.question
    @comment = @answer.comments.build
    if current_user.author_of?(@answer) && @answer.destroy
      flash.now[:notice] = 'Your answer successfully deleted.'
    else
      flash.now[:notice] = 'You can not delete this answer.'
    end
  end

  def set_best_answer_ever
    @question = @answer.question
    @answers = @question.answers
    @comment = @answer.comments.build
    if current_user.author_of?(@question) && @question.answers.find(params[:id]).set_best
      flash.now[:notice] = "Set answer #{params[:id]} as best answer ever!"
    end
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

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
