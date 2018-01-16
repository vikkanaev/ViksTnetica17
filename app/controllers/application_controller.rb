require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  before_action :gon_user, unless: :devise_controller?

  def gon_user
    gon.user_signed_in = user_signed_in?
    gon.current_user_id = current_user.id if current_user
  end

  private

  def success_omniauth_login(user, kind)
    flash[:notice] = "Successfully authenticated from #{kind} account."
    sign_in_and_redirect user, event: :authentication
  end
end
