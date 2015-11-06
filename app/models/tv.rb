class Tv < Resource
  attr_reader :seasons_summary

  def self.find(id)
    build Tmdb::TV.detail(id)
  end

  def seasons
    season_numbers = seasons_summary.map { |season_summary| season_summary['season_number'] }
    season_numbers.map { |season_number| Season.find(id, season_number) }
  end

  def episodes
    episodes = []
    seasons.each do |season|
      episodes += season.episodes
    end
    episodes
  end

  def last_season
    Season.find(id, seasons_summary.last['season_number'])
  end

  def last_episode
    last_season.episodes.last
  end

  def seasons=(seasons_summary)
    @seasons_summary = seasons_summary
  end
end
