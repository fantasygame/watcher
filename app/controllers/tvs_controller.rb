class TvsController < ApplicationController
  def index
    redirect_to :back, alert: 'No name provided' unless params.key?(:name) && params[:name].present?
    @results = TvSearch.new(name: params[:name]).call
  end
end
