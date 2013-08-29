media_divs_length = 0

$ ()->
  $('#add_media').click ()->
    $('.file_fields').append $('<div/>',
      class:'new_media'
      html: $('<input>',
        type:'file'
        name: 'medias[]'
        id: 'checkin_medias'
      )
    )
    media_divs_length += 1
    if media_divs_length>=10
      $('#add_media').hide()

if $('body').data('page') is 'CheckinsEdit'
     checkin_id = $('#edit_map').data 'id'
    $.getJSON '/checkins/'+checkin_id+'/edit.json', (data)->
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
      map = new google.maps.Map document.getElementById("edit_map"), mapOptions
      map.mapTypes.set 'Styled', styledMapType

      #creates the geolocated marker
      marker = new google.maps.Marker
        position: checkinLatLng
        map: map
        draggable: true
        icon: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_black_little.png'

      google.maps.event.addListener marker, 'dragend', ()->
        position = marker.getPosition()
        $('#checkin_latitude').val position.lat()
        $('#checkin_longitude').val position.lng()

      #creates check-in info-window
      infowindow = new google.maps.InfoWindow
        content: 'mark your life here'

      google.maps.event.addListener marker, 'click', ()->
        infowindow.open map, marker

      google.maps.event.addDomListener window, 'load'