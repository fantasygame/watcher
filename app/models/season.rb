class Season < Resource
  attr_reader :episodes_summary

  def self.find(tv_id, number)
    build Tmdb::Season.detail(tv_id, number)
  end

  def episodes(sort: :desc)
    episodes = episodes_summary.map { |episode_summary| Episode.build(episode_summary) }
    episodes.reverse! if sort == :desc
    episodes
  end

  def episodes=(data)
    @episodes_summary = data
  end
end
