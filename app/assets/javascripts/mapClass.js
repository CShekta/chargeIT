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
      L.accessToken = this.mapboxPk;

      var new_map = L.map('map');

      L.tileLayer(this.MapLayer, {
        attribution: this.attribution,
        id: this.mapboxid,
        accessToken: this.mapboxPk,
      }).addTo(new_map);

      this.charge_map = new_map;

      this.charge_map.locate({setView: true, maxZoom: 14});
      this.findBounds(new_map);
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
      $.get( "/map/stations", bounds, function(stationData) {
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
            long: data[i].long
          };

          var popup = L.popup();

          var stationMarker = new L.marker([stationData.lat, stationData.long], {
          }).addTo(leaflet_map)
            .bindPopup('<h5>' + station.name + '</h5><br /><p>This is a nice popup.</p>')
            .openPopup();
        }
      }
    }
  };
})(this);
