if $('body').data('page') is 'CheckinsPast'

  $('form#past_checkin_search').submit (e)->
    e.preventDefault()
    location = $(this).children('#location').val()
    geocoder = new google.maps.Geocoder()
    geocoder.geocode address: location, (results, status)->
      if status is google.maps.GeocoderStatus.OK
        $('.past_checkin_form').slideDown 500
        center = results[0].geometry.location
        $('#checkin_latitude').val center.lat()
        $('#checkin_longitude').val center.lng()
        mapOptions =
          center: center
          zoom: 6
          mapTypeId: 'Styled'
          mapTypeControlOptions:
            mapTypeIds: [ 'Styled']
        map = new google.maps.Map document.getElementById("past_map"), mapOptions
        styledMapType = new google.maps.StyledMapType STYLES, name: 'Styled'
        map.mapTypes.set 'Styled', styledMapType
        marker = new google.maps.Marker
          map: map
          position: results[0].geometry.location
          draggable: true
        google.maps.event.addListener marker, 'dragend', ()->
          position = marker.getPosition()
          $('#checkin_latitude').val position.lat()
          $('#checkin_longitude').val position.lng()
      else
        alert "Geocode was not successful for the following reason: " + status
