function stationCall(e) {
  var coordinates = e.latlng;

  var url = "http://localhost:3000//get_fuel_data";
  $.ajax({
    url: url,
    data: {
        "lat": coordinates.lat,
        "long": coordinates.lng,
    },
    type: "GET",
    success: function(response) {
      console.log("you're ok");
      $("#graphics").load();
    },
    error: function() {
      console.log("I hate you");
    }
});
}
