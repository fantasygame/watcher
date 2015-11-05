class TvSearch
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def call
    search = Tmdb::Search.new
    search.resource('tv')
    search.query(name)
    search.fetch
  end
end