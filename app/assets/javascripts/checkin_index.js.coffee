# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(()->
  
  checkin_map = L.map('map', { center: [51.505, -0.09],zoom: 8 })
  
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(checkin_map)

  $('#show_checkins_map').click ()->
    console.log('poop')
    $.getJSON "/checkins.json", (data)->
      $.each data.checkins, (index, checkin)->
        latlong = new L.LatLng(parseFloat(checkin.latitude),parseFloat(checkin.longitude))
        marker = new L.marker(latlong)
        marker.data = checkin
        checkin_map.addLayer(marker)

)