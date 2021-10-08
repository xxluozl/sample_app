module MicropostsHelper
  def date_format(model)
    date = model.created_at
    if date > 1.day.ago
      time_ago_in_words(date) + '前'
    elsif date > 2.days.ago
      '昨天 ' + date.to_s(:time)
    else
      date.to_s(:db)
    end
  end
end
