class ViewsController < ApplicationController

  def toggle
    created = false
    if current_user.seen_episode_id?(view_params[:episode_id])
      View.where(user: current_user, episode_id: params[:id]).destroy_all
    else
      View.create(view_params.merge(user: current_user))
      created = true
    end
    render json: { episode_id: view_params[:episode_id], created: created }, status: 200
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
