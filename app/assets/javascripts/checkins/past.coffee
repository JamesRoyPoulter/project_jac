if $('body').data('page') is 'CheckinsPast'

  $('form').hide()

  $('.past_checkin_location_search').keypress (e)->
    if e.keyCode is 13
      location = $('#location').val()
      geocoder = new google.maps.Geocoder()
      geocoder.geocode address: location, (results, status)->
        if status is google.maps.GeocoderStatus.OK
          $('form').slideDown 500
          location = results[0].geometry.location
          Ehxe.setFormLatLng location.lat(), location.lng()
          center = new google.maps.LatLng location.lat(), location.lng()
          map = Ehxe.Maps.map 'map', Ehxe.Maps.mapOptions center, 10
          styledMapType = new google.maps.StyledMapType STYLES, name: 'Styled'
          map.mapTypes.set 'Styled', styledMapType
          Ehxe.Maps.placeMarker center, map
          map.setCenter center
          google.maps.event.addListener map, 'click', (event)->
            Ehxe.Maps.clearMarkers()
            Ehxe.Maps.placeMarker event.latLng, map
            Ehxe.setFormLatLng event.latLng.lat(), event.latLng.lng()
        else
          alert "Geocode was not successful for the following reason: " + status
