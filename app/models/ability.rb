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
    can :create, Authorization
    cannot :manage, :profile
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment, Attachment, Subscription]
    can :update, [Question, Answer, Comment, Attachment], user_id: user.id
    can :profile, User, id: user.id

    can [:vote_up, :vote_down], [Answer, Question] do |votable|
      !user.author_of?(votable)
    end

    can :vote_cancel, [Answer, Question] do |votable|
      votable.votes.where(user_id: user.id).any?
    end

    can :set_best_answer_ever, Answer do |answer|
      user.author_of?(answer.question)
    end

    can :destroy, [Question, Answer, Comment, Vote, Subscription], user_id: user.id

    can :destroy, Attachment do |att|
      user.author_of?(att.attachmentable)
    end
  end
end
