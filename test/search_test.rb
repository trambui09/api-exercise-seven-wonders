require_relative "test_helper"

describe "it serches" do
  it "can find one location" do
    location_name = "Gardens Of Babylon"
    response = {}
    VCR.use_cassette("search_endpoint") do
      response = search_by_name(location_name)
    end
    
    expect(response[:name]).must_equal location_name
    expect(response[:lat]).must_equal "50.8241215"
    expect(response[:lon]).must_equal "-0.1506162"
  end 
end
