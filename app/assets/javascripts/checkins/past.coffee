if $('body').data('page') is 'CheckinsPast'
  $('.upload_preview').click ()->
    confirmation = confirm('Are you sure you want to delete this asset?')
    if confirmation is true
      $(this).parents('.new_media').remove()

  $('.past_checkin_location_search').keypress (e)->
    if e.keyCode is 13
      location = $('#location').val()
      geocoder = new google.maps.Geocoder()
      geocoder.geocode address: location, (results, status)->
        if status is google.maps.GeocoderStatus.OK
          $('form').slideDown 500
          location = results[0].geometry.location
          center = new google.maps.LatLng location.lat(), location.lng()
          map = Ehxe.Maps.map 'map', Ehxe.Maps.mapOptions center, 10
          map.mapTypes.set 'Styled', Ehxe.Maps.styledMap()
          marker = Ehxe.Maps.checkinMarker(center, map,'black')
          Ehxe.Maps.markersArray.push marker
          map.setCenter center
          Ehxe.setFormLatLng location.lat(), location.lng()
          google.maps.event.addListener marker, 'dragend', ()->
            position = marker.getPosition()
            Ehxe.setFormLatLng position.lat(), position.lng()

          $('#checkin_category_ids option').click (e)->
            $.getJSON '/categories/'+$(this).attr('value')+'.json', (data)->
              Ehxe.Maps.clearMarkers()
              marker = Ehxe.Maps.checkinMarker(marker.getPosition(),map,data.category.color)
              Ehxe.Maps.markersArray.push marker
              google.maps.event.addListener marker, 'dragend', ()->
                position = marker.getPosition()
                Ehxe.setFormLatLng position.lat(), position.lng()

        else
          alert "Geocode was not successful for the following reason: " + status
