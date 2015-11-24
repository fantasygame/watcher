class EpisodesToSee
  attr_accessor :user, :tvs

  def initialize(user, tvs = [])
    @user = user
    @tvs = tvs
  end

  def call
    results = {}
    if tvs.empty?
      tvs = user.tvs
    end
    tvs.each do |tv|
      tv.seasons.each do |season|
        episodes = season.episodes
        episodes.reject! do |episode|
          seen_episodes_ids(tv).include?(episode.id) || future_episode?(episode)
        end
        unless episodes.empty?
          results[tv] = {} unless results.key?(tv)
          results[tv][season] = episodes
        end
      end
      @seen_episodes_ids = nil
    end
    ToSee::Result.new(results)
  end

  private

  def seen_episodes_ids(tv)
    @seen_episodes_ids ||= View.where(user: user, tv_id: tv.id).map(&:episode_id).uniq
  end

  def future_episode?(episode)
    Time.now.in_time_zone('America/Los_Angeles').to_date.to_s < episode.air_date.to_s
  end
end
