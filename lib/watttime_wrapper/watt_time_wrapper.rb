module Watt_time_Wrapper
  include HTTParty

  def query_data(lat, long)
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")
    if !lat && @current_user
      ba = get_ba(@current_user.latitude, @current_user.longitude)
    elsif !@current_user
      ba = "BPA"
    else
      ba = get_ba(lat.to_s, long.to_s)
    end
    @watttime_calltime = Time.now
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
