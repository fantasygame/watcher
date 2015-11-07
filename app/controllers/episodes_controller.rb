class EpisodesController < ApplicationController
  def index
    @tv = Tv.find(params[:tv_id])
  end

  def to_see
    @results = EpisodesToSee.new(current_user).call
  end
end
