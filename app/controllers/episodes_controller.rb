class EpisodesController < ApplicationController
  def index
    @tv = Tv.find(params[:tv_id])
  end
end
