class CommentsController < ApplicationController
  before_action :find_commentable, only: [:create]

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = 'Your comment successfully created.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def find_commentable
    @commentable ||= if params[:question_id]
                  Question.find(params[:question_id])
                elsif params[:answer_id]
                  Answer.find(params[:answer_id])
                else
                  raise "Commentable entyty"
                end
  end
end
