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

  # GOOGLE MAPS API
    myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    console.log myLatlng

    mapOptions =
      center: myLatlng
      zoom: 16
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById("map"), mapOptions)

    marker = new google.maps.Marker
      position: myLatlng
      map: map
      draggable: true

    google.maps.event.addListener marker, 'dragend', ()->
      position = marker.getPosition()
      $('#checkin_latitude').val position.mb
      $('#checkin_longitude').val position.nb



  google.maps.event.addDomListener(window, 'load', getLocation)
