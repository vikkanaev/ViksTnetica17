class AnswersController < ApplicationController
  before_action :find_question, only: [:create]
  before_action :find_answer, only: [:destroy, :update]
  before_action :authenticate_user!

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @question = @answer.question
    if current_user.author_of?(@answer)
      # Если я пишу if current_user.author_of?(@answer) && @answer.destroy
      # то удаление происходит до присваивания flash[:notice] и рендерится destroy.js.erb без нотиса
      # я решил перенести удаление после присваивания, но счущает что я не проверяю удаление на успешность
      # Как тут лучше сделать?
      flash[:notice] = 'Your answer successfully deleted.'
      @answer.destroy
      @question.save!
    else
      flash[:notice] = 'You can not delete this answer.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end
