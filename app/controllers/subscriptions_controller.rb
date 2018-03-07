class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
  respond_to :js

  def create
    @subscription = current_user.subscriptions.create(question_id: params[:id])
    render :act
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    respond_with(@subscription.destroy, template: 'subscriptions/act')
  end
end
