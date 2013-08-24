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
<<<<<<< HEAD
  myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
=======
    myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
>>>>>>> 3cb11f8110388a5c7d78d3b281d3d7c6e308e6bc

    mapOptions =
      center: myLatlng
      zoom: 16
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById("map"), mapOptions)

<<<<<<< HEAD
  marker = new google.maps.Marker
      position: myLatlng
      map: map
      title: 'Hello World!'
      draggable: true


google.maps.event.addListener(marker, 'dragend', ()->)
=======
    marker = new google.maps.Marker
        position: myLatlng
        map: map
        title: 'Hello World!'
>>>>>>> 3cb11f8110388a5c7d78d3b281d3d7c6e308e6bc

  google.maps.event.addDomListener(window, 'load', getLocation)
