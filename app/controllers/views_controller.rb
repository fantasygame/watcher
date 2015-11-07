class ViewsController < ApplicationController
  def create
    View.create(view_params.merge(user: current_user))
    redirect_to :back
  end

  def destroy
    View.where(user: current_user, episode_id: params[:id]).destroy_all
    redirect_to :back
  end

  def set_all
    SetAsSeen.new(current_user, Tv.find(params[:tv_id]), season_episodes).call
    redirect_to :back
  end

  def unset_all
    SetAsUnseen.new(current_user, Tv.find(params[:tv_id]), season_episodes).call
    redirect_to :back
  end

  private

  def season_episodes
    season = nil
    season = Season.find(params[:tv_id], params[:season_id]) if params[:season_id].present?
    season.present? ? season.episodes : []
  end

  def view_params
    params.require(:view).permit(:tv_id, :episode_id)
  end
end
