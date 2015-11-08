module ToSee
  class Tv
    attr_accessor :tv, :result
    delegate :name, :id, :poster_path, to: :tv

    def initialize(tv, result)
      @tv = tv
      @result = result
    end

    def seasons
      seasons = []
      result.each do |season, episodes|
        seasons << ToSee::Season.new(season, episodes)
      end
      seasons
    end
  end
end
