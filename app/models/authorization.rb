class Authorization < ApplicationRecord
  belongs_to :user

  def self.generate(params)
    user = User.make_new_user(params[:email])
    @auth = Authorization.find_or_create_by(provider: params[:provider], uid: params[:uid], user: user)
    @auth.update! confirmed_at: Time.zone.now
    @auth
  end
end
