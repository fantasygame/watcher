class TvInfo
  attr_reader :id

  def initialize(id:)
    @id = id
  end

  def call
    Tmdb::TV.detail(id)
  end
end
