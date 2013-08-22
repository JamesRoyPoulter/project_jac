# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(()->
  
  map = L.map('map').setView([51.505, -0.09], 8)

  $('#show_checkins_map').click ()->
    $.getJSON "/checkins.json", (data)->
      $.each data.checkins, (index, checkin)->
        marker = new L.marker([parseFloat(checkin.latitude),parseFloat(checkin.longitude)]).addTo(map)

)