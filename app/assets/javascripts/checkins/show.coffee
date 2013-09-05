 $ ()->

  # assets = $('.assets_container .assets')
  # if assets.length > 0
  #   width = 0
  #   assets.children().each (index, element) =>
  #     width += ($(element).width() + 10)
  #   assets.css width: "#{width}px", maxWidth: "#{width}px"

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
        icon: Ehxe.markers[data.checkin.categories[0].color]

      #creates check-in info-window
      infowindow = new google.maps.InfoWindow
        content: 'mark your life here'

      google.maps.event.addListener marker, 'click', ()->
        infowindow.open map, marker

      google.maps.event.addDomListener window, 'load'
