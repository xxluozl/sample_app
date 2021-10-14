module MicropostsHelper
  def date_format(model)
    date = model.created_at
    if date > 1.day.ago
      time_ago_in_words(date.localtime, include_seconds: true)
    elsif date > 2.days.ago
      '昨天 ' + date.to_s(:time)
    else
      date.localtime.to_s(:db)
    end
  end
end
