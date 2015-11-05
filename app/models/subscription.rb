class Subscription < ActiveRecord::Base
  belongs_to :user

  def resource
    Tmdb::TV.detail(resource_id)
  end
end
