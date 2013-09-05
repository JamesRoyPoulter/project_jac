$ ()->

  if $('body').data('page') is 'CheckinsEdit'
    $('#add_media').click ()->
        Ehxe.newCheckinPreviewImage()

    $('.upload_preview').click ()->
      confirmation = confirm('Are you sure you want to delete this asset?')
      if confirmation is true
        $(this).parents('.new_media').siblings('.delete_asset').click()

    checkin_id = $('#map').data 'id'

    $.getJSON '/checkins/'+checkin_id+'/edit.json', (data)->
      location = new google.maps.LatLng(data.checkin.latitude, data.checkin.longitude)

      #generates the map, passing options and style
      map = Ehxe.Maps.map 'map', location, 16
      map.mapTypes.set 'Styled', Ehxe.Maps.styledMap()

      #creates the geolocated marker
      marker = Ehxe.Maps.placeMarker(location, map, 'black', true, data.checkin.title)

      google.maps.event.addListener marker, 'dragend', ()->
        position = marker.getPosition()
        Ehxe.setFormLatLng position.lat(), position.lng()

      #creates check-in info-window
      infowindow = new google.maps.InfoWindow
        content: 'mark your life here'

      google.maps.event.addListener marker, 'click', ()->
        infowindow.open map, marker

      google.maps.event.addDomListener window, 'load'
