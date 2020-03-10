require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://us1.locationiq.com/v1/search.php"

def search_by_name(location)

  response = HTTParty.get("#{BASE_URL}?key=#{ENV["LOCATIONIQ_TOKEN"]}&q=#{location}&format=json")
  response_data = JSON.parse(response.body)
  sleep(1)
  return {lat: response_data.first["lat"], lon: response_data.first["lon"], name: location}
end