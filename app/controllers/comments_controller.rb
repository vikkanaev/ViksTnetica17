class CommentsController < ApplicationController
  before_action :find_commentable, only: [:create]
  after_action :publish_comment, only: [:create]

  authorize_resource

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

  def publish_comment
    comment_parent = @commentable.class.to_s.downcase
    return if @commentable.errors.any?
    if comment_parent == 'question'
      ActionCable.server.broadcast(
        'questions',
          question: ApplicationController.render(
            partial: 'questions/question_channel',
            locals: { question: @commentable }
        )
      )
    elsif comment_parent == 'answer'
      ActionCable.server.broadcast(
        "questions/#{@commentable.question_id}/answers",
          answer: ApplicationController.render(
            partial: 'questions/answer_channel',
            locals: { answer: @commentable }
        )
      )
    end
  end
end
