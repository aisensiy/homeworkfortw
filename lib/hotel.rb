class Hotel
  attr_reader :name, :rating, :strategies
  WEEKDAY = %w{mon tues wed thur fri}
  WEEKEND = %w{sat sun}
  USER_TYPE = %W(regular rewards)

  def initialize(name, rating, strategies)
    @name = name
    @rating = rating
    @strategies = strategies
  end

  def price(args)
    strategies["#{user_type(args[:user_type])} #{day_of_week(args[:day_of_week])}"]
  end

  def user_type type
    type = type.downcase
    type if USER_TYPE.include?(type)
  end

  def day_of_week day
    day = day.downcase
    if WEEKDAY.include? day
      "weekday"
    elsif WEEKEND.include? day
      "weekend"
    else
      nil
    end
  end
end
