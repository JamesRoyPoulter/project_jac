$ ->

  $('.words_button').on 'click', ()->
    $('.media_form').slideUp 500
    $('.words_form').slideDown 500

  $('.media_button').on 'click', ()->
    $('.words_form').slideUp 500
    $('.media_form').slideDown 500

  $('.new_category').on 'click', (e)->
    e.preventDefault()
    $('#new_category').slideDown 500
    $('#existing_category').slideUp 500

  set_form_lat_lng = (lat, long)->
    $('#checkin_latitude').val(lat)
    $('#checkin_longitude').val(long)
    console.log lat, long

  if $('body').data('page') is 'CheckinsNew'

    assignPositionToForm = (position)->
      loc = coords()
      set_form_lat_lng loc[0], loc[1]

    coords = (position)->
      loc = [ position.coords.latitude, position.coords.longitude ]
      return loc

      if (navigator.geolocation)
        navigator.geolocation.getCurrentPosition coords
      else
        $('body').innerHTML= 'Geolocation is not supported by this browser.'

    #***********
    #LEAFLET JS
    #***********

    # creates a map in the "map" divset
    map = new L.map('map')

    # adds an OpenStreetMap tile layer
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo map

    marker = L.marker([coords()[0], coords()[1]], draggable: true).addTo(map).bindPopup("meow").openPopup()

    # # creates a custom icon
    # greenIcon = L.icon(
    #   iconUrl: "leaf-green.png"
    #   shadowUrl: "leaf-shadow.png"
    #   iconSize: [38, 95] # size of the icon
    #   shadowSize: [50, 64] # size of the shadow
    #   iconAnchor: [22, 94] # point of the icon which will correspond to marker's location
    #   shadowAnchor: [4, 62] # the same for the shadow
    #   popupAnchor: [-3, -76] # point from which the popup should open relative to the iconAnchor
    # )

    # marker.on 'dragend', onLocationFound

    # map.on "locationfound", onLocationFound

    #raises error is cannot geolocate
    onLocationError = (e) ->
      alert e.message

    map.on "locationerror", onLocationError



