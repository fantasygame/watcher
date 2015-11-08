class VisitorsController < ApplicationController
  def index
    if user_signed_in?
      @results = EpisodesToSee.new(current_user).call
      render 'episodes/to_see'
    end
  end
end
