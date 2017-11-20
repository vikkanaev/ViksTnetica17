module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(user)
    votes.create(score: 1, user: user)
  end

  def vote_down(user)
    votes.create(score: -1, user: user)
  end

  def vote_cancel(user)
    votes.find_by(user: user).destroy if votes.find_by(user: user)
  end

  def sum_score
    votes.sum(:score)
  end
end
