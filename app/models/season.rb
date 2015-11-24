class Season < Resource
  attr_reader :episodes_summary

  def self.find(tv_id, number)
    loop do
      begin
        return build Tmdb::Season.detail(tv_id, number)
      rescue => e
        raise e unless e.message =~ /over the allowed limit/
      end
    end
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
