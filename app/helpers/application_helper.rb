module ApplicationHelper
  def logo_image_path(image_path, size = 3, alt_img)
    return unless image_path.present?
    configuration = Tmdb::Configuration.new
    "<img src='#{configuration.base_url + configuration.logo_sizes[size] + image_path}' alt='#{alt_img}'>"
  end
end
