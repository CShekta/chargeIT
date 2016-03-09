if ($("#map")) {
  $(document).ready(function() {
    var map = new Map({
      mapboxPk: 'pk.eyJ1Ijoic2hla3RhYmVhciIsImEiOiJjaWw2MG1jbnMwMDVmdWhsdmlqMXBtbDNvIn0.j9O4rlghTMC3oEEGHFSbuQ',
      mapboxid: 'shektabear.pbjom020',
      maxZoom: 18,
      mapLayer: 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}',
      // attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>'
    });

      map.loadMap( function(result) {

        // Populate markers on zoom or move.
        result.on('zoomend viewreset dragend locationfound', function(event) {
            map.findBounds(map.charge_map);
        });

        // create the initial directions object, from which the layer
        // and inputs will pull data.
        var directions = L.mapbox.directions();


        var directionsLayer = L.mapbox.directions.layer(directions)
            .addTo(map.charge_map);

        var directionsInputControl = L.mapbox.directions.inputControl('inputs', directions)
            .addTo(map.charge_map);

        var directionsErrorsControl = L.mapbox.directions.errorsControl('errors', directions)
            .addTo(map.charge_map);

        var directionsRoutesControl = L.mapbox.directions.routesControl('routes', directions)
            .addTo(map.charge_map);

        var directionsInstructionsControl = L.mapbox.directions.instructionsControl('instructions', directions)
            .addTo(map.charge_map);

      });

      $(".directions-icon").click( function() {
        event.preventDefault();
        // $(".directions-icon").toggleClass("fa-flip-vertical");
        $("#directions").slideToggle();
        $("#inputs").slideToggle();
        $("#errors").slideToggle();
      });

        // Find user's current location
        // var geolocate = document.getElementById('geolocate');

        if (!navigator.geolocation) {
          geolocate.innerHTML = 'Geolocation is not available';
        } else {
          $(".geolocate").click = function (e) {
              e.preventDefault();
              e.stopPropagation();
              map.charge_map.locate();
          };
        }
        // var myLayer = L.mapbox.featureLayer().addTo(map.charge_map);

        // Once we've got a position, zoom and center the map
        // on it, and add a single marker.
        map.charge_map.on('locationfound', function(e) {
            map.charge_map.fitBounds(e.bounds);

            L.circleMarker(e.latlng, {
              className: 'current-location'
            })
            .addTo(map.charge_map)

            // myLayer.setGeoJSON({
            //     type: 'Feature',
            //     geometry: {
            //         type: 'Point',
            //         coordinates: [e.latlng.lng, e.latlng.lat]
            //     },
            //     properties: {
            //         'title': 'Here I am!',
            //         'marker-color': '#3CB4D2',
            //         'marker-symbol': 'circle'
            //     }
            // });

            // And hide the geolocation button
            // geolocate.parentNode.removeChild(geolocate);
        });

        // If the user chooses not to allow their location
        // to be shared, display an error message.
        // map.on('locationerror', function() {
        //     geolocate.innerHTML = 'Position could not be found';
        // });

      });

      // // Route to clicked bike node or searched location.
      // $(document).on( "click", ".css-icon", function(event) {
      // collectTrash(trashToCollect);
      // var nodeData = $( this ).data(),
      //   directions = L.mapbox.directions({
      //     profile: 'mapbox.cycling'
      //   }),
      //   routeFormat = {
      //     routeStyle: {
      //       color: '#F60131',
      //       weight: 7,
      //       opacity: 0.75,
      //       className: "route"
      //     }
      //   },
      //   originLatLng = null;
      //
      // if ($(".user-location").data()) {
      //   originLatLng = L.latLng(
      //     $(".user-location").data().lat, $(".user-location").data().lng
      //   );
      //   createRoute();
      //   map.osm_map.locate( { setView: false, watch: true, maximumAge: 5000, maxZoom: 16 } );
      // } else if (typeof(marker) !== 'undefined') {
      //   map.osm_map.stopLocate();
      //   originLatLng = marker.getLatLng();
      //   createRoute();
      // }
      //
      // function createRoute() {
      //   // map.osm_map.locate( { setView: false, watch: true, maximumAge: 5000, maxZoom: 16 } );
      //
      //   // Origin is current location OR searched location
      //   directions.setOrigin(originLatLng);
      //   // Destination is clicked node
      //   directions.setDestination(L.latLng(nodeData.latitude, nodeData.longitude));
      //
      //   directions.query();
      //   var directionsLayer = L.mapbox.directions.layer(directions, routeFormat)
      //     .addTo(map.osm_map);
      //   var directionsRoutesControl = L.mapbox.directions.routesControl('routes', directions)
      //     .addTo(map.osm_map);
      //   var directionsInstructionsControl = L.mapbox.directions.instructionsControl('instructions', directions)
      //     .addTo(map.osm_map);
      //
      //   // Remove layers if another bike node (.css-icon) is clicked
      //   $(document).on( "click", ".css-icon, .my-location, .find-location", function() {
      //     map.osm_map.removeLayer(directionsLayer);
      //     map.osm_map.removeLayer(directionsRoutesControl);
      //   });
      //
      //   showDirectionsIcon();
      // }
      // });
    }
