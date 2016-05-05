class EpisodesToSee
  attr_reader :user
  MAX_SEASONS = 2

  def initialize(user, tvs = [])
    @user = user
    @tvs = tvs
  end

  def call
    results = {}
    @tvs = user.tvs if @tvs.empty?
    @tvs.each do |tv|
      subscription = user.subscriptions.find_by(resource_id: tv.id)
      subscription ||= Struct(season_number: 1, episode_number: 0, finished?: false)
      next if subscription.finished?
      tv.seasons_since(subscription.season_number, MAX_SEASONS).each do |season|
        episodes = season.episodes
        unless season.season_number > subscription.season_number
          episodes.reject! do |episode|
            episode.episode_number <= subscription.episode_number
          end
        end
        episodes.reject! { |episode| future_episode?(episode) }
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
    Time.now.in_time_zone("America/Los_Angeles").to_date.to_s < episode.air_date.to_s
  end
end
