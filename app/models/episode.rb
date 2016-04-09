class Episode < Resource
  def episode_marker(tv_name)
    "#{tv_name} #{season_marker}"
  end

  def season_marker
    "S#{season_number.to_s.rjust(2, '0')}E#{episode_number.to_s.rjust(2, '0')}"
  end
end
