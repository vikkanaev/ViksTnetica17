module VotesHelper
  def vote_btn_show?(votable)
    return votable.votes.exists? ? 'no_display_btn' : ''
  end

  def vote_cancel_show?(votable)
    return votable.votes.exists? ? '' : 'no_display_btn'
  end
end
