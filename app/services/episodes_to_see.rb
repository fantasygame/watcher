class EpisodesToSee
  attr_reader :user

  def initialize(user, tvs = [])
    @user = user
    @tvs = tvs
  end

  def call
    results = {}
    if @tvs.empty?
      @tvs = user.tvs
    end
    @tvs.each do |tv|
      subscription = user.subscriptions.find_by(resource_id: tv.id)
      subscription ||= Struct(season_number: 1, episode_number: 0)
      next if subscription.finished?
      tv.seasons_since(subscription.season_number).each do |season|
        episodes = season.episodes
        episodes.reject! do |episode|
          episode.episode_number <= subscription.episode_number || future_episode?(episode)
        end
        unless episodes.empty?
          results[tv] = {} unless results.key?(tv)
          results[tv][season] = episodes
        end
      end
    end
    ToSee::Result.new(results)
  end

  private

  def future_episode?(episode)
    Time.now.in_time_zone('America/Los_Angeles').to_date.to_s < episode.air_date.to_s
  end
end
