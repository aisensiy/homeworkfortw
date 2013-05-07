class InputProcessor

  def parse(str)
    result = parse_user_type_and_dates(str)
    dates = dates_to_a(result[:dates])
    days = dates.map do |d|
      parse_day_in_week(d)
    end

    {user_type: result[:user_type], days: days}
  end

  private
  def parse_user_type_and_dates(str)
    pn = /(?<user_type>[^:]+):\s*(?<dates>.+)/
    result = pn.match str
    if result.nil?
      nil
    else
      {user_type: result[:user_type].strip, dates: result[:dates].strip}
    end
  end

  def dates_to_a(dates_str)
    dates_str.split(/\s*,\s*/) if !dates_str.nil?
  end

  def parse_day_in_week(date)
    pn = /(\d+)([a-zA-Z]+(\d{4})\((?<day_in_week>[a-zA-Z]+)\))/
    result = pn.match date
    if result.nil?
      nil
    else
      result[:day_in_week]
    end
  end
end
