class InputProcessor

  WEEK = %w{mon tues wed thur fri sat sun}
  USER_TYPE = %W(Regular Rewards)

  def parse(str)
    result = parse_user_type_and_dates(str)
    dates = dates_to_a(result[:dates])
    days = dates.map do |d|
      parse_day_in_week(d)
    end

    {:user_type => result[:user_type], :days => days}
  end

  private
  def parse_user_type_and_dates(str)
    pn = /(?<user_type>[^:]+):\s*(?<dates>.+)/
    result = pn.match str
    if result.nil?
      raise 'invalid input ' + str
    else
      user_type = result[:user_type].strip
      if !USER_TYPE.include?(user_type)
        raise "invalid input with wrong user type #{user_type}"
      end
      {:user_type => user_type, :dates => result[:dates].strip}
    end
  end

  def dates_to_a(dates_str)
    dates_str.split(/\s*,\s*/) if !dates_str.nil?
  end

  def parse_day_in_week(date)
    pn = /(\d+)([a-zA-Z]+(\d{4})\((?<day_in_week>[a-zA-Z]+)\))/
    result = pn.match date
    if result.nil?
      raise "invalid input #{date}"
    else
      if !WEEK.include? result[:day_in_week]
        raise "invalid day of week #{date}"
      end
      result[:day_in_week]
    end
  end
end
