class MapsController < ApplicationController
  include HTTParty
  before_action :authenticate_user!, only: [:map, :stations]
  BASE_URI = "https://api.watttime.org:443/api/v1"

  # production call for energy data
  # def map
  #   @energy_data = get_energy_data_for_location.sort_by { |each| each[:timestamp] }
  # end

# demo call for hard coded data
  def map
    miso = JSON.parse(File.read('lib/hard_data/miso_data.json'))
    hard_data = [miso]
    @energy_data = hard_data.sample
    gon.carbon_perkWh = @energy_data.first["carbon"] / 1000
  end

  def about; end

  def graph_test
    @energy_data = get_energy_data_for_location.sort_by { |each| each[:timestamp] }
    File.write("lib/hard_data/bpa_data.json", @energy_data.to_json)
  end

  def get_fuel_data
    @energy_data = get_energy_data_for_location
    render partial: "shared/carbon"
  end

  def get_energy_data_for_location
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")
    # ba = get_ba(params[:lat].to_s, params[:long].to_s)
    ba = "BPA"
    energy_data = HTTParty.get("#{BASE_URI}/datapoints/?ba=#{ba}&start_at=#{start_time}&market=RT5M", :headers => { "Authorization" => "TOKEN #{ENV['WATT_TIME_TOKEN']}"})
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

  def get_initial_charging_stations
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

  def update_charging_stations(modified_since)
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
