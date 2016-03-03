class CopyViewsToSubscriptions
  def self.call
    Subscription.all.each do |subscription|
      tv = Tv.find(subscription.resource_id)
      episodes = tv.episodes
      latest_view = View
        .where(user: subscription.user, tv_id: subscription.resource_id)
        .order(episode_id: :desc)
        .first
      next if latest_view.blank?
      latest_episode_id = latest_view.episode_id
      lastest_episode = episodes.find { |episode| episode.id == latest_episode_id}
      subscription.update(
        episode_number: lastest_episode.episode_number,
        season_number: lastest_episode.season_number,
      )
    end
  end
end
