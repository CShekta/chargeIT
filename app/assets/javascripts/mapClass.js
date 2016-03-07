(function(exports) {
  "use strict";

  function Map(options) {
    this.mapboxPk = options.mapboxPk;
    this.mapboxid = options.mapboxid;
    this.maxZoom = options.maxZoom;
    this.mapLayer = options.mapLayer;
    this.attribution = options.attribution;
    this.charge_map;
    this.bounds;
  }
  exports.Map = Map;

  Map.prototype = {
    loadMap: function(callback) {
      L.mapbox.accessToken = this.mapboxPk;

      // var new_map = L.map('map',{
      // });

      var new_map = L.mapbox.map('map', {
        zoomControl: false
      });

      L.tileLayer(this.mapLayer, {
        attribution: this.attribution,
        id: this.mapboxid,
        accessToken: this.mapboxPk,
      }).addTo(new_map);

      this.charge_map = new_map;

      new_map.locate({setView: true, maxZoom: 14});

      callback(new_map);
    },


    findBounds: function(map) {
      var bounds = [
        map.getBounds()._southWest.lat,
        map.getBounds()._southWest.lng,
        map.getBounds()._northEast.lat,
        map.getBounds()._northEast.lng
      ];

      this.bounds = bounds;
      this.getStationsFromDB(map);
    },

    getStationsFromDB: function(leaflet_map) {
      // Query db for these bounds
      var this_map = this;
      var bounds = { swLat: this.bounds[0], swLng: this.bounds[1], neLat: this.bounds[2], neLng: this.bounds[3] };

      $.get( "/map_stations", bounds, function(stationData) {
          // populate station markers using DB info
          this_map.createStationMarkers(leaflet_map, stationData.data);
        }, 'json'
      );
    },

    createStationMarkers: function(leaflet_map, data) {
      // create clickable markers for each station in bounds

      for (var i = 0; i < data.length; i++) {

        if (data[i].lat) {
          var stationData = {
            id: data[i].id,
            lat: data[i].lat,
            long: data[i].long,
            title: data[i].title,
            address_line1: data[i].address_line1,
            address_line2: data[i].address_line2,
            usage_cost: data[i].usage_cost,
            phone: data[i].phone,
            comments: data[i].comments,
          };

// marker.bindPopup(popupContent).openPopup();
          var stationMarker = new L.marker([stationData.lat, stationData.long], {
          }).addTo(leaflet_map);
          stationMarker.bindPopup('<h5>' + stationData.title + '</h5><br>' + stationData.address_line1 + '<br>Cost: ' + stationData.usage_cost + '<br>Contact Number: ' + stationData.phone + '<br>Comments:  '+ stationData.comments);
        }
      }
    }
  };
})(this);
