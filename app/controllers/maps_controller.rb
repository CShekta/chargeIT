require 'pry'
class MapsController < ApplicationController
  include HTTParty
  LAT = -122.272778
  LONG = 37.871667

  def map
    # @name = get_balancing_authority(LAT, LONG)
    # ba = get_abbrev_by_location(LAT, LONG)
    #
    # response = HTTParty.get("https://api.watttime.org:443/api/v1/datapoints/?ba=#{ba}&page_size=1", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    # @carbon = response["results"][0]["carbon"]
    # @genmix = response["results"][0]["genmix"]

    response = HTTParty.get("https://api.watttime.org:443/api/v1/datapoints/?ba=BPA&start_at=2016-02-23&freq=5m&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    @response = response["results"]

  end

  def get_balancing_authority(lat,long)
    response = HTTParty.get("https://api.watttime.org/api/v1/balancing_authorities/?loc={'type':'Point','coordinates':[#{lat},#{long}]}")
    @name = response[0]["name"]
  end

  def get_abbrev_by_location(lat,long)
    response = HTTParty.get("https://api.watttime.org/api/v1/balancing_authorities/?loc={'type':'Point','coordinates':[#{lat},#{long}]}")
    abbrev = response[0]["abbrev"]
  end

  def get_fuel_sources()

  end




end
