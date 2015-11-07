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
    SetAsSeen.new(current_user, Tv.find(params[:tv_id])).call
    redirect_to :back
  end

  def unset_all
    SetAsUnseen.new(current_user, Tv.find(params[:tv_id])).call
    redirect_to :back
  end

  private

  def view_params
    params.require(:view).permit(:tv_id, :episode_id)
  end
end
