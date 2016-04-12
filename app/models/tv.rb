class Tv < Resource
  attr_reader :seasons_summary

  def self.find(id)
    loop do
      begin
        return build Tmdb::TV.detail(id)
      rescue => e
        raise e unless e.message =~ /over the allowed limit/
      end
    end
  end

  def seasons(sort: :asc)
    seasons_since(0, nil, sort: sort)
  end

  def seasons_since(season_number, limit = nil, sort: :asc)
    season_numbers_since = season_numbers.reject { |number| number < season_number }
    season_numbers_since = season_numbers_since[0..(limit - 1)] if limit.present?
    seasons = season_numbers_since.map { |number| Season.find(id, number) }
    seasons.sort_by! { |e| - e.season_number } if sort == :desc
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
    Season.find(id, seasons_summary.last["season_number"])
  end

  def last_episode
    last_season.episodes.last
  end

  def season_numbers
    seasons_summary.map { |season_summary| season_summary["season_number"] }
  end

  def seasons=(seasons_summary)
    @seasons_summary = seasons_summary
  end
end
