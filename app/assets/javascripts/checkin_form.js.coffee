if $('body').data('page') is 'CheckinsNew'

  $('.new_category').click (e)->
    e.preventDefault()
    $('#existing_category').slideUp 500
    $('#new_category').slideDown 500

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

  #Sets the styles for the Google Maps API
    styles = [
      {
        "featureType": "water",
        "stylers": [
          { "saturation": -8 },
          { "color": "#00009d" },
          { "hue": "#00eeff" }
        ]
      },{
        "featureType": "landscape.man_made",
        "elementType": "labels.text",
        "stylers": [
          { "hue": "#fff700" },
          { "saturation": -49 }
        ]
      },{
        "featureType": "landscape.natural",
        "elementType": "geometry",
        "stylers": [
          { "hue": "#ffe500" },
          { "saturation": 46 },
          { "lightness": -23 }
        ]
      },{
        "featureType": "road.highway",
        "stylers": [
          { "hue": "#ff3c00" },
          { "visibility": "simplified" }
        ]
      },{
        "elementType": "labels.text.fill",
        "stylers": [
          { "color": "#008080" },
          { "gamma": 0.82 }
        ]
      },{
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
          { "visibility": "off" }
        ]
      },{
        "featureType": "road.arterial",
        "stylers": [
          { "hue": "#ffb300" }
        ]
      },{
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
          { "visibility": "on" },
          { "weight": 0.1 },
          { "hue": "#b300ff" }
        ]
      },{
        "featureType": "landscape.man_made",
        "stylers": [
          { "visibility": "on" },
          { "hue": "#ffff00" },
          { "saturation": 84 },
          { "lightness": -15 },
          { "gamma": 1.24 }
        ]
      },{
        "featureType": "landscape.natural.landcover",
        "stylers": [
          { "hue": "#ff002b" }
        ]
      },{
        "featureType": "landscape.natural.terrain",
        "stylers": [
          { "hue": "#ff0011" }
        ]
      },{
        "featureType": "administrative",
        "stylers": [
          { "weight": 1.4 }
        ]
      },{
        "featureType": "administrative.province",
        "elementType": "geometry",
        "stylers": [
          { "visibility": "on" },
          { "gamma": 0.75 },
          { "weight": 1.3 },
          { "hue": "#ffe500" },
          { "color": "#727272" }
        ]
      },{
        "featureType": "road.highway",
        "elementType": "labels.icon",
        "stylers": [
          { "hue": "#fff700" },
          { "lightness": 21 },
          { "visibility": "on" }
        ]
      },{
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
          { "visibility": "on" }
        ]
      },{
        "featureType": "poi.government",
        "elementType": "geometry",
        "stylers": [
          { "hue": "#00ff11" },
          { "saturation": -7 },
          { "gamma": 1.14 },
          { "lightness": 25 },
          { "color": "#7c9189" }
        ]
      },{
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          { "color": "#7d8080" }
        ]
      }
    ]

  # GOOGLE MAPS API
  #sets lat and lng to current location
    myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    console.log myLatlng

  #assigns map options using current location and styles
    mapOptions =
      center: myLatlng
      zoom: 16
      mapTypeId: 'Styled'
      mapTypeControlOptions:
        mapTypeIds: [ 'Styled']

    styledMapType = new google.maps.StyledMapType(styles, { name: 'Styled' })

    #generates the map, passing options and style
    map = new google.maps.Map(document.getElementById("map"), mapOptions )
    map.mapTypes.set('Styled', styledMapType)

    #creates the geolocated marker
    marker = new google.maps.Marker
      position: myLatlng
      map: map
      draggable: true
      title: 'mark your life here X'
      # icon: 'assets/markers/exhe_marker_mint.png'

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

