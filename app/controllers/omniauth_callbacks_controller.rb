class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authorize

  def facebook; end

  def twitter; end

  private

  def authorize
    @auth = request.env['omniauth.auth']
    @authorization = Authorization.where(provider: @auth.provider, uid: @auth.uid.to_s).first

    if @authorization
      if @authorization.confirmed_at.present?
        success_omniauth_login(@authorization.user, @authorization.provider.capitalize)
      else
        render 'authorization/unconfirmed'
      end
    else
      create_new_authorization
    end
  end

  def create_new_authorization
    if @auth.info && @auth.info[:email]
      @user = User.find_for_oauth(@auth)
      if @user
        success_omniauth_login(@user, @auth.provider.capitalize)
      else
        redirect_to new_user_registration_url
      end
    else
      session[:auth] = { uid: @auth.uid, provider: @auth.provider }
      @authorization = Authorization.new(provider: @auth.provider, uid: @auth.uid.to_s)
      render 'authorization/new'
    end
  end
end
