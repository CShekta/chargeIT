require 'pry'
class MapsController < ApplicationController
  include HTTParty
  LAT = -122.272778
  LONG = 37.871667
  BASE_URI = "https://api.watttime.org:443/api/v1"

  def map
    gon.stations = Station.all
    # ba = get_ba(params[:lat], params[:lng])
    #
    # response = HTTParty.get("https://api.watttime.org:443/api/v1/datapoints/?ba=#{ba}&page_size=1", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    @response = get_fuel_data


    # response = HTTParty.get("#{BASE_URI}/marginal/?ba=BPA&start_at=2016-02-23&freq=5m&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    # @response = response["results"]
  end

  def about

  end

  def graph_test
    response = HTTParty.get("#{BASE_URI}/datapoints/?ba=BPA&start_at=2016-02-27&freq=5m&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    @response = response["results"]
  end

  def map_test
    gon.stations = Station.all
  end

  def get_fuel_data
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")
    response = HTTParty.get("#{BASE_URI}/datapoints/?ba=BPA&start_at=#{start_time}&freq=5m&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    response = response["results"]
  end

  def get_balancing_authority(lat,long)
    response = HTTParty.get("#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{lat},#{long}]}")
    @name = response[0]["name"]
  end

  def get_ba(lat,long)
    response = HTTParty.get("#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{lat},#{long}]}")
    abbrev = response[0]["abbrev"]
  end

  def get_fuel_sources()

  end




end
