module ToSee
  class Season
    attr_accessor :season, :episodes
    delegate :season_number, :id, to: :season

    def initialize(season, episodes)
      @season = season
      @episodes = episodes
    end
  end
end
