class Episode < Resource
  def episode_marker(tv_name)
    "#{tv_name} #{season_marker}"
  end

  def season_marker
    "S#{season_number.to_s.rjust(2, '0')}E#{episode_number.to_s.rjust(2, '0')}"
  end

  def torrent_link(tv_name, type)
    "#{base_torrent_link(type)}/#{URI.encode(episode_marker(tv_name))}"
  end

  private

  def base_torrent_link(type)
    case type
    when :thepiratebay
      "https://thepiratebay.se/search"
    else
      fail "Unknown type"
    end
  end
end
