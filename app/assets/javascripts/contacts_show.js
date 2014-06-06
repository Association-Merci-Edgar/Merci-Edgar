var mapAlreadyLoaded = false
function displayMap() {
  mapElement = $("#map")
  if (mapElement.length > 0) {
    data1 = mapElement.data()
    options = {address: data1.address}
    geocodedPrecisely = data1.geocodedPrecisely
    if (!geocodedPrecisely && data1.address) {
      jQuery.ajax({
        url: "https://maps.googleapis.com/maps/api/geocode/json?" + jQuery.param(options) + '&sensor=false',
        type: "GET",
        success: function(data) {
          result = data.results[0]
          latlng = result.geometry.location
          address_options = { latitude: latlng.lat, longitude: latlng.lng }
          mapElement.data("geocodedPrecisely", true)
          jQuery.ajax({
            url: data1.path + "?" + jQuery.param(address_options),
            type: "PUT"
          })
          loadMap(mapElement[0], latlng.lat, latlng.lng)
          
        }
      });

    }
    else {
      if (!mapAlreadyLoaded && data1.latitude && data1.longitude) { 
        loadMap(mapElement[0], data1.latitude, data1.longitude)
        
      }
      
    }
  } 
}
function loadMap(element, latitude, longitude) {
  latlng = new google.maps.LatLng(latitude, longitude)
  mapOptions = {
    center: latlng,
    zoom: 6
  }
  map = new google.maps.Map(element, mapOptions)
  marker = new google.maps.Marker({ position: latlng, map: map })
  mapAlreadyLoaded = true
  
}
$('a[data-toggle="tab"]').on('shown', function (e) {
  if (e.target.toString().match("#infos") != null) {
    displayMap();
  }
});
$(function(){
  displayMap();
})