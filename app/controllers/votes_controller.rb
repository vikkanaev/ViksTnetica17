class VotesController < ApplicationController
  def vote_up
    unless current_user.author_of?(votable)
      votable.vote_up(current_user)
      render json: { id: @votable.id, score: @votable.sum_score, have_vote: true, type: votable.class.to_s }
    else
      render json: { message: "You can`t vote for your #{votable.class.to_s}", status: :unprocessable_entity }
    end
  end

  def vote_down
    votable.vote_down(current_user)
  end

  def vote_cancel
    votable.vote_cancel(current_user)
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
