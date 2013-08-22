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

#***********
#LEAFLET JS
#***********

# creates a map in the "map" divset
# map = new L.map('map')

# adds an OpenStreetMap tile layer
# L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
#     attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
# }).addTo(map);

# geolocates user
# map.locate({setView: true, maxZoom: 16});

# # creates a custom icon
# greenIcon = L.icon(
#   iconUrl: "leaf-green.png"
#   shadowUrl: "leaf-shadow.png"
#   iconSize: [38, 95] # size of the icon
#   shadowSize: [50, 64] # size of the shadow
#   iconAnchor: [22, 94] # point of the icon which will correspond to marker's location
#   shadowAnchor: [4, 62] # the same for the shadow
#   popupAnchor: [-3, -76] # point from which the popup should open relative to the iconAnchor
# )

#sets marker with popup
onLocationFound = (e) ->
  radius = e.accuracy / 2
  # If using custom markers, pass the marker image as an option to the marker, such as {icon: greenIcon}
  L.marker(e.latlng, draggable: true).addTo(map).bindPopup("You are within " + radius + " meters of this point").openPopup()
  # Creates radius circle beneath marker
  # L.circle(e.latlng, radius).addTo map
# map.on "locationfound", onLocationFound


#raises error is cannot geolocate
onLocationError = (e) ->
  alert e.message
# map.on "locationerror", onLocationError



# GOOGLE MAPS API
      #   myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

      #   mapOptions =
      #     center: myLatlng
      #     zoom: 16
      #     mapTypeId: google.maps.MapTypeId.ROADMAP

      #   map = new google.maps.Map(document.getElementById("map"), mapOptions)

      #   marker = new google.maps.Marker
      #       position: myLatlng
      #       map: map
      #       title: 'Hello World!'

      # google.maps.event.addDomListener(window, 'load', getLocation)