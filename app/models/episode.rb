class Episode < Resource
  def season_marker
    "S#{season_number.to_s.rjust(2, '0')}E#{episode_number.to_s.rjust(2, '0')}"
  end
end
