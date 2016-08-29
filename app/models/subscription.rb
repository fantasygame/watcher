class Subscription < ApplicationRecord
  belongs_to :user

  def resource
    Tv.find(resource_id)
  end

  def finished?
    false # TODO
  end
end
