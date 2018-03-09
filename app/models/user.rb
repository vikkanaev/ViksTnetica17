class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  def author_of?(object)
    object.user_id == id
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    user = make_new_user(auth.info[:email])
    user.authorizations.create(provider: auth.provider, uid: auth.uid, confirmed_at: Time.zone.now) if user
    user
  end

  def self.make_new_user(email)
    user = User.where(email: email).first
    return user if user

    password = Devise.friendly_token[0, 20]
    user = User.new(email: email, password: password, password_confirmation: password)
    # user.skip_confirmation!
    user.save!
    user
  end

  def self.send_daily_digest
    find_each.each do |user|
      DailyMailer.digest(user).deliver_later
    end
  end

  def subscribed?(question)
    subscriptions.where(question_id: question).exists?
  end
end
