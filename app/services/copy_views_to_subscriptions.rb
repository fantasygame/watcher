class CopyViewsToSubscriptions
  def self.call
    Subscription.all.each do |subscription|
      subscription.update(episode_number: 1, season_number: 1)
      tv = Tv.find(subscription.resource_id)
      episodes = tv.episodes
      latest_view = View
        .where(user: subscription.user, tv_id: subscription.resource_id)
        .order(episode_id: :desc)
        .first
      next if latest_view.blank?
      latest_episode_id = latest_view.episode_id
      lastest_episode = episodes.find { |episode| episode.id == latest_episode_id}
      next if lastest_episode.blank?
      subscription.update(
        episode_number: lastest_episode.episode_number,
        season_number: lastest_episode.season_number,
      )
    end
  end
end
