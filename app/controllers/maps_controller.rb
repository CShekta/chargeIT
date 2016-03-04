require 'pry'
class MapsController < ApplicationController
  include HTTParty
  BASE_URI = "https://api.watttime.org:443/api/v1"
  current_ba = nil   #the balancing authority previously called
  watttime_calltime = nil  #the time watttime api was just called
  ev_calltime = nil  #the time when openchargemap was previously called

  def map
    @energy_data = query_data

    # energy_data = HTTParty.get("#{BASE_URI}/datapoints/?ba=BPA&start_at=#{start_time}&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    # @energy_data = energy_data["results"]

  end

  def stations
    sw_lat = params[:swLat]
    sw_lng = params[:swLng]
    ne_lat = params[:neLat]
    ne_lng = params[:neLng]
    stations = Station.where( 'lat >= ' + sw_lat + ' AND lat <= ' + ne_lat + ' AND long <= ' + ne_lng + ' AND long >= ' + sw_lng)
    elements = []

    stations.each do |station|
      station_hash =
      {
        id: station.id,
        lat: station.lat,
        long: station.long,
        title: station.title,
        address_line1: station.address_line1,
        address_line2: station.address_line2,
        usage_cost: station.usage_cost,
        phone: station.phone,
        comments: station.comments,
      }
      elements << station_hash
    end
    render json: { data: elements, status: 200 }.as_json

  end

  def about; end

  def graph_test
    energy_data = HTTParty.get("#{BASE_URI}/datapoints/?ba=BPA&start_at=2016-02-27&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    @energy_data = energy_data["results"]
  end

  def map_test
    # @stations = HTTParty.get("http://api.openchargemap.io/v2/poi/?output=json&countrycode=US&opendata=true&maxresults=10000")
    # @stations.each do |station|
    #   Station.create(
    #     ev_id: station["ID"],
    #     lat: station["AddressInfo"]["Latitude"],
    #     long: station["AddressInfo"]["Longitude"],
    #     title: station["AddressInfo"]["Title"],
    #     address_line1: station["AddressInfo"]["AddressLine1"],
    #     address_line2: station["AddressInfo"]["AddressLine2"],
    #     city: station["AddressInfo"]["Town"],
    #     state: station["AddressInfo"]["StateOrProvince"],
    #     zip: station["AddressInfo"]["Postcode"],
    #     usage_cost: station["UsageCost"],
    #     phone: station["AddressInfo"]["ContactTelephone1"],
    #     comments: station["GeneralComments"],
    #   )
    # end
  end


  def get_fuel_data
    render json: query_data, status: 200
  end

  def query_data
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")
    if !params[:lat] && @current_user
      ba = get_ba(@current_user.latitude, @current_user.longitude)
    elsif !@current_user
      ba = "BPA"
    else
      ba = get_ba(params[:lat].to_s, params[:long].to_s)
    end
    energy_data = HTTParty.get("#{BASE_URI}/datapoints/?ba=#{ba}&start_at=#{start_time}&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
    energy_data = energy_data["results"]
  end

  # def get_balancing_authority(lat,long)
  #   balancing_authority = HTTParty.get("#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{lat},#{long}]}")
  #   balancing_authority_name = balancing_authority[0]["name"]
  # end

  def get_ba(lat,long)
    query = "#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{long},#{lat}]}"
    balancing_authority = HTTParty.get(query)
    ba = balancing_authority[0]["abbrev"]
  end
end
