class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :views
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def tvs
    subscriptions.map(&:resource)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name'] || '' if auth['info']
      user.email = auth['info']['email']
    end
  end

  def subscribed?(resource_id)
    subscriptions.map(&:resource_id).include?(resource_id)
  end

  def seen?(episode)
    views.where(episode_id: episode.id).present?
  end
end
