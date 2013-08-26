if $('body').data('page') is 'CheckinsNew'

  #gets location from browser
  getLocation = ()->
    if (navigator.geolocation)
      navigator.geolocation.getCurrentPosition assignPositionToForm
    else
      x.innerHTML= 'Geolocation is not supported by this browser.'

  #assigns location to hidden form fields
  assignPositionToForm = (position)->
    $('#checkin_latitude').val(position.coords.latitude)
    $('#checkin_longitude').val(position.coords.longitude)

    # GOOGLE MAPS API
    #sets lat and lng to current location
    myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

    #assigns map options using current location and styles
    mapOptions =
      center: myLatlng
      zoom: 16
      mapTypeId: 'Styled'
      mapTypeControlOptions:
        mapTypeIds: [ 'Styled']

    styledMapType = new google.maps.StyledMapType(STYLES, { name: 'Styled' })

    #generates the map, passing options and style
    map = new google.maps.Map(document.getElementById("map"), mapOptions )
    map.mapTypes.set('Styled', styledMapType)

    #creates the geolocated marker
    marker = new google.maps.Marker
      position: myLatlng
      map: map
      draggable: true
      title: 'mark your life here X'
      icon: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_black_little.png'

    #creates check-in info-window
    infowindow = new google.maps.InfoWindow
      content: 'mark your life here'

    google.maps.event.addListener marker, 'dragend', ()->
      position = marker.getPosition()
      $('#checkin_latitude').val position.mb
      $('#checkin_longitude').val position.nb

    google.maps.event.addListener(marker, 'click', ->
      infowindow.open(map, marker))

  google.maps.event.addDomListener(window, 'load', getLocation)

