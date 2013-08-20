# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


getLocation = ()->
  if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition assignPositionToForm
  else 
    x.innerHTML= 'Geolocation is not supported by this browser.'

assignPositionToForm = (position)->
  $('#checkin_latitude').val(position.coords.latitude)
  $('#checkin_longitude').val(position.coords.longitude)

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