require 'httparty'
require "awesome_print"

BASE_URL = "https://us1.locationiq.com/v1/search.php?"
LOCATION_IQ_KEY = "b2f441ce4caa9b"

# takes in a seven wonder string
# returns a nested hash with lat and long hashes insides
def get_location(search_term)

  search_term_string = "#{search_term.gsub(/[\s]/, '%20')}"

  # couldn't get the query to work properly
  query = {
      key: LOCATION_IQ_KEY,
      q: search_term_string
  }
  url = "#{BASE_URL}key=#{LOCATION_IQ_KEY}&q=#{search_term_string}&format=json"

  response = HTTParty.get(url)
  return {search_term => {:lat => response[0]["lat"], :lon => response[0]["lon"]}}

end

def find_seven_wonders

  seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  seven_wonders_locations = []

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end

  return seven_wonders_locations
end


# Use awesome_print because it can format the output nicely
ap find_seven_wonders
# Expecting something like:
# [{"Great Pyramid of Giza"=>{:lat=>"29.9791264", :lon=>"31.1342383751015"}}, {"Gardens of Babylon"=>{:lat=>"50.8241215", :lon=>"-0.1506162"}}, {"Colossus of Rhodes"=>{:lat=>"36.3397076", :lon=>"28.2003164"}}, {"Pharos of Alexandria"=>{:lat=>"30.94795585", :lon=>"29.5235626430011"}}, {"Statue of Zeus at Olympia"=>{:lat=>"37.6379088", :lon=>"21.6300063"}}, {"Temple of Artemis"=>{:lat=>"32.2818952", :lon=>"35.8908989553238"}}, {"Mausoleum at Halicarnassus"=>{:lat=>"37.03788265", :lon=>"27.4241455276707"}}]
