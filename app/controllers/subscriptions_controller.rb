class SubscriptionsController < ApplicationController

  def create
    if current_user.subscriptions.find_by(resource_id: params[:resource_id]).present?
      redirect_to :back, alert: 'Already in Your resources.'
    else
      Subscription.find_or_create_by(user_id: current_user.id, resource_id: params[:resource_id])
      redirect_to :back, notice: 'Resource has been added'
    end
  end
end
