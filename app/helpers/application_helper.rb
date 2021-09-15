module ApplicationHelper
  def full_title(title)
    title.empty? ? "A Sample App" : "#{title} | A Sample App"
  end
end
