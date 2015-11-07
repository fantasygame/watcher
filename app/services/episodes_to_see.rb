class EpisodesToSee
  attr_reader :user, :tvs
  attr_accessor :seen_episodes_ids

  def initialize(user, tvs = [])
    @user = user
    @tvs = tvs
  end

  def call
    results = []
    tvs = user.tvs if @tvs.empty?
    tvs.each do |tv|
      episodes = tv.episodes
      episodes.reject! { |episode| seen_episodes_ids(tv).include?(episode.id) }
      results << OpenStruct.new(tv: tv, episodes: episodes) unless episodes.empty?
    end
    results
  end

  def seen_episodes_ids(tv)
    @seen_episodes_ids ||= View.where(user: user, tv_id: tv.id).map(&:episode_id).uniq
  end
end
