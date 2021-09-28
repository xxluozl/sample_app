module ApplicationHelper
  include Pagy::Frontend

  def nl2br(str)
    return str if str.blank?
    sanitize(str).gsub(/\R/, "<br>").html_safe
  end

  def full_title(title)
    title.empty? ? "Sample App" : "#{title} | Sample App"
  end
end
