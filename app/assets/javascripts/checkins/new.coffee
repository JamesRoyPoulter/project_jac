mediaAddNumber = 0

page = $('body').data('page')

if page is 'CheckinsNew' || page is 'CheckinsPast' || page is 'CheckinsEdit'

  $('#checkin_description').click () ->
    $(@).css 'text-align', 'left'

  $('.x_icon').click ()->
    $(@).parent('.new_media').remove()

  mediaAddNumber += 1
  if mediaAddNumber>=10
    $('#add_media').hide()


#MAPPING BELOW
if $('body').data('page') is 'CheckinsNew'
  $ ()->

    #gets location from browser
    getLocation = ()->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition assignPositionToForm
      else
        x.innerHTML = 'Geolocation is not supported by this browser.'

    #assigns location to hidden form fields
    assignPositionToForm = (position)->
      Ehxe.setFormLatLng position.coords.latitude, position.coords.longitude

      #sets lat and lng to current location
      myLatlng = new google.maps.LatLng position.coords.latitude, position.coords.longitude

      map = Ehxe.Maps.map 'map', Ehxe.Maps.mapOptions(myLatlng, 16)
      map.mapTypes.set 'Styled', Ehxe.Maps.styledMap()

      #creates the geolocated marker
      marker = new google.maps.Marker
        position: myLatlng
        map: map
        draggable: true
        title: 'mark your life here X'
        icon: Ehxe.markers.black
      Ehxe.Maps.markersArray.push marker

      #creates check-in info-window
      infowindow = new google.maps.InfoWindow
        content: 'mark your life here'

      position = ''

      google.maps.event.addListener marker, 'dragend', ()->
        position = marker.getPosition()
        Ehxe.setFormLatLng position.lat(), position.lng()

      google.maps.event.addListener marker, 'click', ()->
        infowindow.open map, marker

      $('#add_media').click ()->
        Ehxe.newCheckinPreviewImage()

      $('#checkin_category_ids option').click (e)->
        $.getJSON '/categories/'+$(this).attr('value')+'.json', (data)->
          marker = new google.maps.Marker
            position: marker.getPosition()
            map: map
            draggable: true
            title: 'mark your life here X'
            icon: Ehxe.markers[data.category.color]

          google.maps.event.addListener marker, 'dragend', ()->
            position = marker.getPosition()
            console.log(position.lat(), position.lng())
            Ehxe.setFormLatLng position.lat(), position.lng()

          Ehxe.Maps.clearMarkers()
          Ehxe.Maps.markersArray.push marker

    google.maps.event.addDomListener window, 'load', getLocation

