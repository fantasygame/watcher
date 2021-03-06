module ApplicationHelper
  def logo_image_path(image_path, size, alt_img)
    if image_path.present?
      configuration = Tmdb::Configuration.new
      src = configuration.base_url + configuration.logo_sizes[size] + image_path
      "<img src='#{src}' alt='#{alt_img}'>"
    else
      no_image(size, alt_img)
    end
  end

  def no_image(size, alt_img)
    case size
    when 1
      img_size = "92x135"
    when 2
      img_size = "154x226"
    when 3
      img_size = "185x272"
    when 4
      img_size = "300x441"
    when 5
      img_size = "500x735"
    end
    image_tag("no_image.png", alt: alt_img.to_s, size: img_size.to_s)
  end
end
