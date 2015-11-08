class Tv < Resource
  attr_reader :seasons_summary

  def self.find(id)
    build Tmdb::TV.detail(id)
  end

  def seasons(sort: :desc)
    season_numbers = seasons_summary.map { |season_summary| season_summary['season_number'] }
    seasons = season_numbers.map { |season_number| Season.find(id, season_number) }
    seasons.sort_by!{ |e| - e.season_number } if sort == :desc
    seasons
  end

  def episodes
    episodes = []
    seasons.each do |season|
      episodes += season.episodes
    end
    episodes
  end

  def year
    return unless first_air_date.present?
    first_date = first_air_date[0..3]
    last_date = last_air_date[0..3]
    first_date != last_date ? "(#{first_date} - #{last_date})" : "(#{first_date})"
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
