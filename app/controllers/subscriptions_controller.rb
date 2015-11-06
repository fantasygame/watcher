class SubscriptionsController < ApplicationController

  def create
    if current_user.subscriptions.find_by(resource_id: params[:resource_id]).present?
      redirect_to :back, alert: 'Already in Your resources.'
    else
      Subscription.find_or_create_by(user_id: current_user.id, resource_id: params[:resource_id])
      redirect_to :back, notice: 'Resource has been added'
    end
  end

  def index
    tvs = []
    current_user.subscriptions.each do |subscription|
      tvs = TvInfo.new(id: subscription.resource_id).call
    end
  end

  def destroy
    current_user.subscriptions.find_by(resource_id: params[:id]).destroy
    redirect_to :back, notice: 'Resource has been succesfully removed from your subscriptions'
  end
end
