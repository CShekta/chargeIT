require 'pry'
class MapsController < ApplicationController
  include HTTParty
  include WattTimeWrapper

  before_action :authenticate_user!, only: [:map, :stations]


  BASE_URI = "https://api.watttime.org:443/api/v1"
  @@latest_ba ||= nil   #the balancing authority previously called
  @@watttime_calltime ||= nil  #the time watttime api was just called
  @@latest_energy_data ||= []
  @@latest_ev_calltime ||= nil  #the time when openchargemap was previously called
  @@latest_marginal ||= [] #latest marginal carbon data
  @@working_bas = ["BPA", "CAISO", "MISO", "ISONE"].cycle

  # def initialize
  #   @current_energy_data = {}
  #   @current_marginal_data = {}
  #   @current_ba = {}
  #
  # end

  def letsencrypt
    render plain: ENV['LE_AUTH_RESPONSE']
  end

  def map


    #update station database if needed
    # if @@latest_ev_calltime.nil? || @@latest_ev_calltime < Time.now - 2.weeks
    #   @@latest_ev_calltime = Time.now - 2.weeks
    #   call_for_charging_stations(@@latest_ev_calltime)
    #   @@latest_ev_calltime = Time.now
    # end
    #get energy data from watt time
    @energy_data = get_energy_data_for_location.sort_by { |each| each[:timestamp] }
    @marginal_carbon = get_marginal.sort_by { |each| each[:timestamp] }
    # binding.pry
  end

  def about; end

  def graph_test
  end

  def get_fuel_data
    @energy_data = get_energy_data_for_location
    render partial: "shared/carbon"
  end

  def get_energy_data_for_location
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")
    working_bas = ["BPA", "CAISO", "MISO", "ISONE"]
    if start_time
      ba = working_bas.sample
    else
      ba = get_ba(params[:lat].to_s, params[:long].to_s)
    end
    energy_data = HTTParty.get("#{BASE_URI}/datapoints/?ba=#{ba}&start_at=#{start_time}&market=RT5M", :headers => { "Authorization" => "TOKEN #{ENV['WATT_TIME_TOKEN']}"})
    puts "ba: #{ba}"
    @energy_data = energy_data["results"]
  end

  def get_ba(lat,long)
    query = "#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{long},#{lat}]}"
    balancing_authority = HTTParty.get(query)
    ba = balancing_authority[0]["abbrev"]
  end

  def get_marginal
    start_time = (Time.now - 1.day).strftime("%Y-%m-%d")
    marginal_carbon = HTTParty.get("#{BASE_URI}/marginal/?ba=PSEI", :headers => { "Authorization" => "TOKEN #{ENV['WATT_TIME_TOKEN']}"})
    @latest_marginal = marginal_carbon["results"]
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

  def map_test
    @response = HTTParty.get("http://api.openchargemap.io/v2/poi/?output=json&countrycode=US&opendata=true&maxresults=10000")
    @response.each do |station|
      Station.create(
        ev_id: station["ID"],
        lat: station["AddressInfo"]["Latitude"],
        long: station["AddressInfo"]["Longitude"],
        title: station["AddressInfo"]["Title"],
        address_line1: station["AddressInfo"]["AddressLine1"],
        address_line2: station["AddressInfo"]["AddressLine2"],
        city: station["AddressInfo"]["Town"],
        state: station["AddressInfo"]["StateOrProvince"],
        zip: station["AddressInfo"]["Postcode"],
        usage_cost: station["UsageCost"],
        phone: station["AddressInfo"]["ContactTelephone1"],
        comments: station["GeneralComments"],
      )
    end
  end

  def call_for_charging_stations(modified_since)
    @stations = HTTParty.get("http://api.openchargemap.io/v2/poi/?output=json&countrycode=US&opendata=true&modifiedsince=#{modified_since}&maxresults=10000")
    @stations.each do |station|
      Station.where('ev_id = ?', station["ID"]).update(
        lat: station["AddressInfo"]["Latitude"],
        long: station["AddressInfo"]["Longitude"],
        title: station["AddressInfo"]["Title"],
        address_line1: station["AddressInfo"]["AddressLine1"],
        address_line2: station["AddressInfo"]["AddressLine2"],
        city: station["AddressInfo"]["Town"],
        state: station["AddressInfo"]["StateOrProvince"],
        zip: station["AddressInfo"]["Postcode"],
        usage_cost: station["UsageCost"],
        phone: station["AddressInfo"]["ContactTelephone1"],
        comments: station["GeneralComments"],
      )
    end
  end
end
