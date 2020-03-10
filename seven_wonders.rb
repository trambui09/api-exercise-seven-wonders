require 'httparty'
require 'awesome_print'

#Starter Code:
seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

BASE_URL = "https://us1.locationiq.com/v1/search.php"
key = "da6565bd8527c5"

seven_wonders_locations = seven_wonders.map do |wonder|
  # Code to discover the locations of each wonder.
  response = HTTParty.get("#{BASE_URL}?key=#{key}&q=#{wonder}&format=json")
  response_data = JSON.parse(response.body)
  sleep(1)
  {lat: response_data.first["lat"], lon: response_data.first["lon"], name: wonder}
end

ap seven_wonders_locations

ap "********"

ap "Driving Directions from Cairo to The great pyramid"

DRIVING_BASE_URL = "https://us1.locationiq.com/v1/directions/driving/"
pyramid = {lon: 31.243666, lat: 30.048819}
cairo = {lon: 27.4241280469557, lat: 37.03785995}

response = HTTParty.get("#{DRIVING_BASE_URL}#{pyramid[:lon]},#{pyramid[:lat]};#{cairo[:lon]},#{cairo[:lat]}?key=#{key}")

ap JSON.parse(response.body)

locations = [{ lat: 38.8976998, lon: -77.0365534886228}, {lat: 48.4283182, lon: -123.3649533 }, { lat: 41.8902614, lon: 12.493087103595503}]

REVERSE_LOOKUP_BASE = "https://us1.locationiq.com/v1/reverse.php"

ap "Reverse look up locations"
locations.each do |location|
  response = HTTParty.get("#{REVERSE_LOOKUP_BASE}?key=#{key}&lat=#{location[:lat]}&lon=#{location[:lon]}&format=json")
  ap JSON.parse(response.body)["display_name"]
  sleep(1)
end


#Example Output:
#{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}
