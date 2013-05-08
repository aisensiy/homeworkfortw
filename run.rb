require_relative './lib/hotel'
require_relative './lib/input_processor'

def read_from_stdin
  ARGF.read.split("\n")
end

def calculate_total_price(hotel, user, days)
  days.map do |day|
    hotel.price(:user_type => user, :day_of_week => day)
  end.inject {|sum, x| sum + x}
end

def prepare_hotels
  [
    Hotel.new(:name => "Lakewood", :rating => 3, :strategies => {
      "regular weekday" => 110,
      "regular weekend" => 90,
      "rewards weekday" => 80,
      "rewards weekend" => 80
    }),
    Hotel.new(:name => "Bridgewood", :rating => 4, :strategies => {
      "regular weekday" => 160,
      "regular weekend" => 60,
      "rewards weekday" => 110,
      "rewards weekend" => 50
    }),
    Hotel.new(:name => "Ridgewood", :rating => 5, :strategies => {
      "regular weekday" => 220,
      "regular weekend" => 150,
      "rewards weekday" => 100,
      "rewards weekend" => 40
    })
  ]

end

def run
  lines = read_from_stdin
  input_processor = InputProcessor.new
  hotels = prepare_hotels

  lines.each do |line|
    result =
      begin
        input_processor.parse(line)
      rescue RuntimeError
        nil
      end

    next if result.nil?

    results = hotels.map do |hotel|
      total = calculate_total_price(hotel, result[:user_type], result[:days])
      [total, -hotel.rating, hotel.name]
    end
    puts results.sort.first.last
  end
end

run
