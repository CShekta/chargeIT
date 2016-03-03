require 'pry'
class MapsController < ApplicationController
  include HTTParty
  LAT = -122.272778
  LONG = 37.871667
  BASE_URI = "https://api.watttime.org:443/api/v1"

  def map
    gon.stations = Station.all
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")

    # ba = get_ba(params[:lat], params[:lng])
    #
    # response = HTTParty.get("https://api.watttime.org:443/api/v1/datapoints/?ba=#{ba}&page_size=1", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})

    # @response = query_data

    # response = HTTParty.get("#{BASE_URI}/datapoints/?ba=BPA&start_at=#{start_time}&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    # @response = response["results"]

  end

  def stations
    sw_lat = params[:swLat]
    sw_lng = params[:swLng]
    ne_lat = params[:neLat]
    ne_lng = params[:neLng]
    stations = Station.where( 'lat >= ' + sw_lat + ' AND lat <= ' + ne_lat + ' AND long >= ' + ne_lng + ' AND long <= ' + sw_lng)
    elements = []

    stations.each do |station|
      station_hash =
      {
        id: station.id,
        lat: station.lat,
        long: station.long,
      }
      elements << station_hash
    end
    render json: { data: elements, status: 200 }.as_json

  end

  def about; end

  def graph_test
    response = HTTParty.get("#{BASE_URI}/datapoints/?ba=BPA&start_at=2016-02-27&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    @response = response["results"]
  end

  def map_test
    # @response = HTTParty.get("http://api.openchargemap.io/v2/poi/?output=json&countrycode=US&opendata=true&maxresults=10000")
    # @response.each do |station|
    #   Station.create(
    #     ev_id: station["ID"],
    #     lat: station["AddressInfo"]["Latitude"],
    #     long: station["AddressInfo"]["Longitude"],
    #     usage_cost: station["UsageCost"],
    #     phone: station["AddressInfo"]["ContactTelephone1"],
    #     comments: station["GeneralComments"],
    #   )
    # end
  end

  # response = HTTParty.get("#{BASE_URI}/datapoints/?ba=BPA&start_at=#{start_time}&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
  # response = response["results"]

  def get_fuel_data
    render json: query_data, status: 200
  end

  def query_data
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")
    if !params[:lat]
      ba = "BPA"
    else
      ba = get_ba(params[:lat].to_s, params[:long].to_s)
    end
    response = HTTParty.get("#{BASE_URI}/datapoints/?ba=#{ba}&start_at=#{start_time}&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    response = response["results"]
  end

  # def get_balancing_authority(lat,long)
  #   response = HTTParty.get("#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{lat},#{long}]}")
  #   @name = response[0]["name"]
  # end

  def get_ba(lat,long)
    query = "#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{long},#{lat}]}"
    response = HTTParty.get(query)
    abbrev = response[0]["abbrev"]
  end
end
