class Hotel
  attr_reader :name, :rating
  WEEKDAY = %w{mon tues wed thur fri}
  WEEKEND = %w{sat sun}

  def initialize(name, rating)
    @name = name
    @rating = rating
  end

  def price(user, day)
    if weekday? day
      if regular? user
        110
      elsif rewards? user
        80
      end
    elsif weekend? day
      if regular? user
        90
      elsif rewards? user
        80
      end
    end
  end

  def weekday?(day)
    reg = WEEKDAY.map {|d| "(#{d})"}.join("|")
    !( day =~ Regexp.new("^#{reg}$", Regexp::IGNORECASE) ).nil?
  end

  def weekend?(day)
    !( day =~ /^(sat)|(sun)$/i ).nil?
  end

  def regular?(user)
    !( user =~ /^regular$/i ).nil?
  end

  def rewards?(user)
    !( user =~ /^rewards$/i ).nil?
  end

end
