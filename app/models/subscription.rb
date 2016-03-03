class Subscription < ActiveRecord::Base
  belongs_to :user

  def resource
    Tv.find(resource_id)
  end

  def finished?
    false # TODO
  end
end
