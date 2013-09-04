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

          locationx = results[0].geometry.location
          center = new google.maps.LatLng locationx.lat(), locationx.lng()
          Ehxe.setFormLatLng locationx.lat(), locationx.lng()

          map = Ehxe.Maps.map 'map', Ehxe.Maps.mapOptions(center, 12)
          map.mapTypes.set 'Styled', Ehxe.Maps.styledMap()

          #creates the geolocated marker
          marker = new google.maps.Marker
            position: center
            map: map
            draggable: true
            title: 'mark your life here X'
            icon: Ehxe.markers.black
          Ehxe.Maps.markersArray.push marker

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
