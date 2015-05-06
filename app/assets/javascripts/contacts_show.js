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
          result = parseGeocodeResult(data.results[0])
          address_options = {
            latitude: result.lat, longitude: result.lng,
            admin_name1: result.administrative_area_level_1,
            admin_name2: result.administrative_area_level_2
          }

          console.log("parsing: " + JSON.stringify(address_options))
          mapElement.data("geocodedPrecisely", true)
          jQuery.ajax({
            url: data1.path + "?" + jQuery.param(address_options),
            type: "PUT"
          })
          loadMap(mapElement[0], result.lat, result.lng)
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

function parseGeocodeResult(geocodeResult){
  var parsed = {lat: geocodeResult.geometry.location.lat,
    lng: geocodeResult.geometry.location.lng};
    _addressParts = {administrative_area_level_1: null, administrative_area_level_2: null}

    for (var addressPart in _addressParts){
      parsed[addressPart] = findInfo(geocodeResult, addressPart);
    }

    parsed.type = geocodeResult.types[0];
    return parsed;
}

function findInfo(result, type) {
  for (var i = 0; i < result.address_components.length; i++) {
    var component = result.address_components[i];
    if (component.types.indexOf(type) !=-1) {
      return component.long_name;
    }
  }
  return false;
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
