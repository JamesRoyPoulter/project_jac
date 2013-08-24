
#gets location from browser
getLocation = ()->
  if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition assignPositionToForm
  else
    x.innerHTML= 'Geolocation is not supported by this browser.'

#assigns location to hidden form fields
assignPositionToForm = (position)->
  $('#checkin_latitude').val(position.coords.latitude)
  $('#checkin_longitude').val(position.coords.longitude)

# GOOGLE MAPS API
  myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

  mapOptions =
    center: myLatlng
    zoom: 16
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map"), mapOptions)

  marker = new google.maps.Marker
      position: myLatlng
      map: map
      title: 'Hello World!'

google.maps.event.addDomListener(window, 'load', getLocation)
