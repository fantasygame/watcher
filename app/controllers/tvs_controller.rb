class TvsController < ApplicationController
  def index
    redirect_to :back, alert: 'No name provided' unless valid_params?
    @results = TvSearch.new(name: search_param).call
  end

  private

  def valid_params?
    params.key?(:search) && search_param.present?
  end

  def search_param
    params[:search][:name]
  end
end
