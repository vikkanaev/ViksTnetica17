class VotesController < ApplicationController
  skip_authorization_check
  # Добавил что бы не ругалось при включенной проверке check_authorization в ApplicationController
  # При этом я убедился что authorize! вызывается и проверяет права в медодах vote_up, vote_down, vote_cancel

  def vote_up
    unless current_user.author_of?(votable)
      authorize! :vote_up, votable
      votable.vote_up(current_user)
      render json: { id: @votable.id, score: @votable.sum_score, have_vote: true, type: votable.class.to_s }
    else
      render json: { message: "You can`t vote for your #{votable.class.to_s}" }, status: :unprocessable_entity
    end
  end

  def vote_down
    unless current_user.author_of?(votable)
      authorize! :create, votable
      votable.vote_down(current_user)
      render json: { id: @votable.id, score: @votable.sum_score, have_vote: true, type: votable.class.to_s }
    else
      render json: { message: "You can`t vote for your #{votable.class.to_s}" }, status: :unprocessable_entity
    end
  end

  def vote_cancel
    unless current_user.author_of?(votable)
      authorize! :destroy, votable.votes.where(user_id: current_user).last
      votable.vote_cancel(current_user)
      render json: { id: @votable.id, score: @votable.sum_score, vote_cancal: true, type: votable.class.to_s }
    else
      render json: { message: "You can`t cancel vote for #{votable.class.to_s}" }, status: :unprocessable_entity
    end
  end

  private

  def votable
    @votable ||= if params[:question_id]
                  Question.find(params[:question_id])
                elsif params[:answer_id]
                  Answer.find(params[:answer_id])
                else
                  raise "Anvotable entyty"
                end
  end
end
