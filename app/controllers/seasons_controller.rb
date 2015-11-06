class SeasonsController < ApplicationController
  def show
    @season = Season.find(params[:tv_id], params[:id])
  end
end
