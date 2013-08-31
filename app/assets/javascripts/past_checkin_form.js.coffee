if $('body').data('page') is 'CheckinsPast'

  markersArray = []

  placeMarker = (location, map)->
    marker = new google.maps.Marker
      position: location
      icon: Ehxe.markers.black
      map: map
    markersArray.push marker

  $('.past_checkin_location_search').keypress (e)->
    if e.keyCode is 13
      location = $('#location').val()
      geocoder = new google.maps.Geocoder()
      geocoder.geocode address: location, (results, status)->
        if status is google.maps.GeocoderStatus.OK
          $('.past_checkin_form').slideDown 500
          center = results[0].geometry.location
          Ehxe.setFormLatLng center.lat(), center.lng()
          map = Ehxe.Maps.map 'past_map', Ehxe.Maps.mapOptions center, 12
          styledMapType = new google.maps.StyledMapType STYLES, name: 'Styled'
          map.mapTypes.set 'Styled', styledMapType
          google.maps.event.addListener map, 'click', (event)->
            for i in markersArray
              i.setMap null
            placeMarker event.latLng, map
            Ehxe.setFormLatLng event.latLng.lat(), event.latLng.lng()
        else
          alert "Geocode was not successful for the following reason: " + status
