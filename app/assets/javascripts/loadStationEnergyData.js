function loadStationEnergyData(e) {
  var coordinates = e.latlng;

  var url = "/get_fuel_data";
  $.ajax({
    url: url,
    data: {
        "lat": coordinates.lat,
        "long": coordinates.lng,
    },
    type: "GET",
    success: function(response) {
      console.log("you're ok");
      $("#carbon-graph").html(response).fadeIn().delay(2000);
    },
    error: function( request, status, error) {
      console.log(error);
    }
});
}
