if ($("#map")) {
  $(document).ready(function() {
    var map = new Map({
      mapboxPk: 'pk.eyJ1Ijoic2hla3RhYmVhciIsImEiOiJjaWw2MG1jbnMwMDVmdWhsdmlqMXBtbDNvIn0.j9O4rlghTMC3oEEGHFSbuQ',
      mapboxid: 'mapbox.emerald',
      maxZoom: 18,
      mapLayer: 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}',
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>'
    });

    map.loadMap( function(result) {
      // Populate markers on zoom or move.
      result.on('zoomend, moveend', function(event) {
        var zoom = result.getZoom();
        if (zoom > 11) {
          map.findBounds(map.charge_map);
        } else {
          // setTimeout(function() {
          //   $('.css-icon').remove();
          //   showAlert(alertContent.zoomAlert);
          // }, 250);
        }
      });
    });

  });
}

// var map = L.map('map')
//
// map.locate({setView: true, maxZoom: 14});
//
// L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
//     attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
//     maxZoom: 18,
//     id: 'mapbox.emerald',
//     accessToken: 'pk.eyJ1Ijoic2hla3RhYmVhciIsImEiOiJjaWw2MG1jbnMwMDVmdWhsdmlqMXBtbDNvIn0.j9O4rlghTMC3oEEGHFSbuQ'
// }).addTo(map);
//
// var stations = gon.stations;
//
// stations.forEach(function(station) {
//   L.marker([station.lat, station.long]).addTo(map)
//       .bindPopup('<h5>' + station.name + '</h5><br /><p>This is a nice popup.</p>')
//       .openPopup()
//       .on('click', onClick);
// });
// var popup = L.popup();
//
// function onClick(e) {
//   var coordinates = e.latlng;
//   var url = "http://localhost:3000//get_fuel_data"
//   $.ajax({
//     url: url,
//     data: {
//         "lat": coordinates.lat,
//         "long": coordinates.lng,
//     },
//     type: "GET",
//     success: function(response) {
//       console.log("you're ok");
//       $("#graphics").load();
//     },
//     error: function() {
//       console.log("I hate you");
//     }
// });
// }