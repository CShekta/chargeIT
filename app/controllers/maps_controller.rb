class MapsController < ApplicationController
  include HTTParty
  include WattTimeWrapper

  before_action :authenticate_user!


  BASE_URI = "https://api.watttime.org:443/api/v1"
  @@latest_ba ||= nil   #the balancing authority previously called
  @@watttime_calltime ||= nil  #the time watttime api was just called
  @@latest_energy_data ||= nil
  @@latest_ev_calltime ||= nil  #the time when openchargemap was previously called

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
    # @energy_data = query_data
    @energy_data = [
    {
      "timestamp": "2016-03-07T18:40:00Z",
      "created_at": "2016-03-07T18:48:01.173487Z",
      "carbon": 171.261726976833,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1789
        },
        {
          "fuel": "hydro",
          "gen_MW": 11271
        },
        {
          "fuel": "wind",
          "gen_MW": 2609
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4014313/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T18:35:00Z",
      "created_at": "2016-03-07T18:38:01.249726Z",
      "carbon": 171.362852213916,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1788
        },
        {
          "fuel": "hydro",
          "gen_MW": 11261
        },
        {
          "fuel": "wind",
          "gen_MW": 2602
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4014193/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T18:25:00Z",
      "created_at": "2016-03-07T18:33:01.024874Z",
      "carbon": 170.656962267765,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1782
        },
        {
          "fuel": "hydro",
          "gen_MW": 11242
        },
        {
          "fuel": "wind",
          "gen_MW": 2639
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4014131/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T18:20:00Z",
      "created_at": "2016-03-07T18:28:02.222429Z",
      "carbon": 170.88122605364,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1784
        },
        {
          "fuel": "hydro",
          "gen_MW": 11248
        },
        {
          "fuel": "wind",
          "gen_MW": 2628
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4014070/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T18:15:00Z",
      "created_at": "2016-03-07T18:23:01.462761Z",
      "carbon": 170.51747183502,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1786
        },
        {
          "fuel": "hydro",
          "gen_MW": 11344
        },
        {
          "fuel": "wind",
          "gen_MW": 2581
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4014009/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T18:10:00Z",
      "created_at": "2016-03-07T18:18:01.131147Z",
      "carbon": 171.488656640326,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1794
        },
        {
          "fuel": "hydro",
          "gen_MW": 11377
        },
        {
          "fuel": "wind",
          "gen_MW": 2521
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013947/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T18:05:00Z",
      "created_at": "2016-03-07T18:08:01.042808Z",
      "carbon": 171.532381438042,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1794
        },
        {
          "fuel": "hydro",
          "gen_MW": 11373
        },
        {
          "fuel": "wind",
          "gen_MW": 2521
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013826/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:55:00Z",
      "created_at": "2016-03-07T18:03:19.326299Z",
      "carbon": 173.047177107502,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1790
        },
        {
          "fuel": "hydro",
          "gen_MW": 11359
        },
        {
          "fuel": "wind",
          "gen_MW": 2367
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013759/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:50:00Z",
      "created_at": "2016-03-07T17:53:12.020716Z",
      "carbon": 172.131147540984,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1792
        },
        {
          "fuel": "hydro",
          "gen_MW": 11491
        },
        {
          "fuel": "wind",
          "gen_MW": 2333
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013638/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:45:00Z",
      "created_at": "2016-03-07T17:48:02.907114Z",
      "carbon": 171.002658564375,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1801
        },
        {
          "fuel": "hydro",
          "gen_MW": 11765
        },
        {
          "fuel": "wind",
          "gen_MW": 2232
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013575/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:35:00Z",
      "created_at": "2016-03-07T17:38:00.683683Z",
      "carbon": 173.357318689642,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1831
        },
        {
          "fuel": "hydro",
          "gen_MW": 11925
        },
        {
          "fuel": "wind",
          "gen_MW": 2087
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013453/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:30:00Z",
      "created_at": "2016-03-07T17:33:00.808679Z",
      "carbon": 176.296720061022,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1849
        },
        {
          "fuel": "hydro",
          "gen_MW": 11929
        },
        {
          "fuel": "wind",
          "gen_MW": 1954
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013393/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:20:00Z",
      "created_at": "2016-03-07T17:23:01.189357Z",
      "carbon": 178.293585001913,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1864
        },
        {
          "fuel": "hydro",
          "gen_MW": 11936
        },
        {
          "fuel": "wind",
          "gen_MW": 1882
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013274/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:10:00Z",
      "created_at": "2016-03-07T17:18:00.887595Z",
      "carbon": 181.059205914218,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1894
        },
        {
          "fuel": "hydro",
          "gen_MW": 12022
        },
        {
          "fuel": "wind",
          "gen_MW": 1775
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013211/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:05:00Z",
      "created_at": "2016-03-07T17:13:01.045325Z",
      "carbon": 180.837563451777,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1900
        },
        {
          "fuel": "hydro",
          "gen_MW": 12154
        },
        {
          "fuel": "wind",
          "gen_MW": 1706
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013150/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T17:00:00Z",
      "created_at": "2016-03-07T17:08:01.945804Z",
      "carbon": 180.087154225085,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1901
        },
        {
          "fuel": "hydro",
          "gen_MW": 12234
        },
        {
          "fuel": "wind",
          "gen_MW": 1699
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013090/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:55:00Z",
      "created_at": "2016-03-07T17:03:00.818780Z",
      "carbon": 178.510998307953,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1899
        },
        {
          "fuel": "hydro",
          "gen_MW": 12376
        },
        {
          "fuel": "wind",
          "gen_MW": 1682
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4013004/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:50:00Z",
      "created_at": "2016-03-07T16:58:00.882164Z",
      "carbon": 175.784863998026,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1900
        },
        {
          "fuel": "hydro",
          "gen_MW": 12662
        },
        {
          "fuel": "wind",
          "gen_MW": 1651
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012942/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:45:00Z",
      "created_at": "2016-03-07T16:48:01.107481Z",
      "carbon": 175.614728777956,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1895
        },
        {
          "fuel": "hydro",
          "gen_MW": 12692
        },
        {
          "fuel": "wind",
          "gen_MW": 1599
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012823/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:35:00Z",
      "created_at": "2016-03-07T16:38:00.796732Z",
      "carbon": 175.824857355495,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1890
        },
        {
          "fuel": "hydro",
          "gen_MW": 12654
        },
        {
          "fuel": "wind",
          "gen_MW": 1580
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012701/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:25:00Z",
      "created_at": "2016-03-07T16:33:00.921909Z",
      "carbon": 176.760476072403,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1901
        },
        {
          "fuel": "hydro",
          "gen_MW": 12715
        },
        {
          "fuel": "wind",
          "gen_MW": 1516
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012641/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:20:00Z",
      "created_at": "2016-03-07T16:28:01.967309Z",
      "carbon": 177.828307999003,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1903
        },
        {
          "fuel": "hydro",
          "gen_MW": 12692
        },
        {
          "fuel": "wind",
          "gen_MW": 1457
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012579/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:15:00Z",
      "created_at": "2016-03-07T16:23:02.230951Z",
      "carbon": 177.28376611246,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1898
        },
        {
          "fuel": "hydro",
          "gen_MW": 12753
        },
        {
          "fuel": "wind",
          "gen_MW": 1408
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012520/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:10:00Z",
      "created_at": "2016-03-07T16:18:02.906344Z",
      "carbon": 177.836016473231,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1900
        },
        {
          "fuel": "hydro",
          "gen_MW": 12749
        },
        {
          "fuel": "wind",
          "gen_MW": 1377
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012457/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    },
    {
      "timestamp": "2016-03-07T16:05:00Z",
      "created_at": "2016-03-07T16:13:01.314543Z",
      "carbon": 178.428553569196,
      "genmix": [
        {
          "fuel": "thermal",
          "gen_MW": 1903
        },
        {
          "fuel": "hydro",
          "gen_MW": 12707
        },
        {
          "fuel": "wind",
          "gen_MW": 1388
        }
      ],
      "url": "https://api.watttime.org/api/v1/datapoints/4012397/",
      "market": "RT5M",
      "freq": "5m",
      "ba": "BPA"
    }]
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


  def get_fuel_data
    render json: query_data, status: 200
  end

  def query_data
    start_time = (Time.now - 2.day).strftime("%Y-%m-%d")

    if !params[:lat] && current_user #the user logged in but hasn't used the map yet
      # ba = get_ba(current_user.latitude, current_user.longitude)
      ba = "CAISO"
    else #use the coordinates from the map click
      ba = get_ba(params[:lat].to_s, params[:long].to_s)
    end
    if @@latest_ba == ba && @@watttime_calltime < Time.now - 15.min #user is requesting info from the same ba
      return @@latest_energy_data
    else
      energy_data = HTTParty.get("#{BASE_URI}/datapoints/?ba=#{ba}&start_at=#{start_time}&market=RT5M", headers={'Authorization': "Token #{ENV['WATT_TIME_TOKEN']}"})
      @@watttime_calltime = Time.now
      @@latest_energy_data = energy_data["results"]
    end
  end

  def get_balancing_authority(lat,long)
    balancing_authority = HTTParty.get("#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{lat},#{long}]}")
    balancing_authority_name = balancing_authority[0]["name"]
  end

  def get_ba(lat,long)
    query = "#{BASE_URI}/balancing_authorities/?loc={'type':'Point','coordinates':[#{long},#{lat}]}"
    balancing_authority = HTTParty.get(query)
    ba = balancing_authority[0]["abbrev"]
  end
end
