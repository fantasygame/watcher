class User < ApplicationRecord
  has_many :subscriptions
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= if User.count == 0
                    :admin
                  else
                    :user
                  end
  end

  def tvs
    subscriptions.map(&:resource)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"] || "" if auth["info"]
      user.email = auth["info"]["email"]
    end
  end

  def subscribed?(resource_id)
    subscriptions.map(&:resource_id).include?(resource_id)
  end

  def seen?(resource, episode)
    subscription = Subscription.find_by(resource_id: resource.id)
    return false if subscription.blank? || resource.blank? || episode.blank?
    if subscription.season_number > episode.season_number
      true
    elsif subscription.season_number < episode.season_number
      false
    else
      subscription.episode_number >= episode.episode_number
    end
  end

  def seen_episode_id?(episode_id)
    views.where(episode_id: episode_id).present?
  end
end
