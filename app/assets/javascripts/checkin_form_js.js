var assignPositionToForm, getLocation, map, onLocationError, onLocationFound;

getLocation = function() {
  if (navigator.geolocation) {
    return navigator.geolocation.getCurrentPosition(assignPositionToForm);
  } else {
    return x.innerHTML = 'Geolocation is not supported by this browser.';
  }
};

assignPositionToForm = function(position) {
  $('#checkin_latitude').val(position.coords.latitude);
  return $('#checkin_longitude').val(position.coords.longitude);
};

map = L.map('map');

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

map.locate({
  setView: true,
  maxZoom: 16
});

onLocationFound = function(e) {
  var radius;
  radius = e.accuracy / 2;
  return L.marker(e.latlng, {
    draggable: true
  }).addTo(map).bindPopup("You are within " + radius + " meters of this point").openPopup();
};

map.on("locationfound", onLocationFound);

onLocationError = function(e) {
  return alert(e.message);
};

map.on("locationerror", onLocationError);