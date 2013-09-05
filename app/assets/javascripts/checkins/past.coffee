if $('body').data('page') is 'CheckinsPast'

  $('#add_media').click ()->
    Ehxe.newCheckinPreviewImage()
    $('.previews').scrollLeft(1300)

  $('.past_checkin_location_search').keypress (e)->
    if e.keyCode is 13
      location = $('#location').val()
      Ehxe.Maps.geocoder.geocode address: location, (results, status)->
        if status is google.maps.GeocoderStatus.OK
          $('form').slideDown 500

          location = results[0].geometry.location
          center = Ehxe.Maps.latlng location.lat(), location.lng()
          Ehxe.setFormLatLng location.lat(), location.lng()

          map = Ehxe.Maps.map 'map', center, 12
          Ehxe.Maps.styleMap map, 'Styled'

          #creates the geolocated marker
          marker = Ehxe.Maps.placeMarker(Ehxe.Maps.mapCenter(map),map,'black',true,'mark your life')

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
