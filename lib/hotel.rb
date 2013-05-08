class Hotel
  attr_reader :name, :rating, :strategies

  WEEKDAY = %w{mon tues wed thur fri}
  WEEKEND = %w{sat sun}
  USER_TYPE = %W(regular rewards)

  def initialize(args)
    @name = args[:name]
    @rating = args[:rating]
    @strategies = args[:strategies]

    if name.nil? or rating.nil? or strategies.nil?
      raise "parameters are invalid"
    end
  end

  def price(arg)
    strategies["#{user_type(arg[:user_type])} #{day_of_week(arg[:day_of_week])}"]
  end

  def user_type type
    type = type.downcase if type
    type if USER_TYPE.include?(type)
  end

  def day_of_week day
    day = day.downcase if day
    if WEEKDAY.include? day
      "weekday"
    elsif WEEKEND.include? day
      "weekend"
    else
      nil
    end
  end
end
