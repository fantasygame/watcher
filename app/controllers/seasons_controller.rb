class SeasonsController < ApplicationController
  def show
    @tv = Tv.find(params[:tv_id])
    @season = Season.find(@tv.id, params[:id])
  end
end
