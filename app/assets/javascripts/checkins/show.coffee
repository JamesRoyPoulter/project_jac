 $ ()->
  if $('body').data('page') is 'CheckinsShow'
    checkin_id = $('.show_checkin_container').data 'id'
    $.getJSON '/checkins/'+checkin_id+'.json', (data)->
      checkinLatLng = new google.maps.LatLng(data.checkin.latitude, data.checkin.longitude)

      mapOptions =
        center: checkinLatLng
        zoom: 16
        minZoom: 1
        mapTypeId: 'Styled'
        mapTypeControlOptions:
          mapTypeIds: ['Styled']

      styledMapType = new google.maps.StyledMapType STYLES, name: 'Styled'

      #generates the map, passing options and style
      map = new google.maps.Map document.getElementById("map"), mapOptions
      map.mapTypes.set 'Styled', styledMapType

      #creates the geolocated marker
      marker = new google.maps.Marker
        position: checkinLatLng
        map: map
        icon: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_black_little.png'

      #creates check-in info-window
      infowindow = new google.maps.InfoWindow
        content: 'mark your life here'

      google.maps.event.addListener marker, 'click', ()->
        infowindow.open map, marker

      google.maps.event.addDomListener window, 'load'
