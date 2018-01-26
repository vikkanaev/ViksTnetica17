class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    guest_abilities
    can :create, [Question, Answer, Comment, Attachment]
    can :update, [Question, Answer, Comment, Attachment], user_id: user.id

    can [:vote_up, :vote_down], [Answer, Question] do |votable|
      votable.user_id != user.id
    end

    can :vote_cancel, [Answer, Question] do |votable|
      votable.votes.where(user_id: user.id).any?
    end

    can :set_best_answer_ever, Answer do |answer|
      answer.question.user_id == user.id
    end

    can :destroy, [Question, Answer, Comment, Vote], user_id: user.id

    can :destroy, Attachment do |att|
      att.attachmentable.user_id == user.id
    end
  end
end
