class SubscriptionsController < ApplicationController
  def create
    if current_user.subscriptions.find_by(resource_id: params[:resource_id]).present?
      redirect_to :back, alert: "Already in Your resources."
    else
      Subscription.find_or_create_by(
        user_id: current_user.id,
        resource_id: params[:resource_id],
        episode_number: 1,
        season_number: 1
      )
      redirect_to :back, notice: "Resource has been added"
    end
  end

  def seen
    subscription = Subscription.find_or_create_by(
      user_id: current_user.id,
      resource_id: params[:resource_id],
    )
    subscription.update(
      episode_number: params[:episode_number],
      season_number: params[:season_number]
    )
    render(
      json: {
        season_number: params[:season_number],
        episode_number: params[:episode_number],
        tv_number: params[:resource_id]
      },
      status: 200
    )
  end

  def index
    @tvs = current_user.tvs
  end

  def destroy
    current_user.subscriptions.find_by(resource_id: params[:id]).destroy
    redirect_to :back, notice: "Resource has been succesfully removed from your subscriptions"
  end
end
