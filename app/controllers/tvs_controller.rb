class TvsController < ApplicationController
  def index
    redirect_to :back, alert: 'No name provided' unless valid_params?
    @tvs = TvSearch.new(name: search_param).call
  end

  def show
    @tv = Tv.find(params[:id])
  end

  private

  def valid_params?
    params.key?(:search) && search_param.present?
  end

  def search_param
    params[:search][:name]
  end
end
