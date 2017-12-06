class CommentsController < ApplicationController
  before_action :find_question, only: [:create]
  #before_action :find_answer, only: [:destroy, :update, :set_best_answer_ever]

  def create
    @comment = @question.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = 'Your comment successfully created.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end
