$ ->
  if $('body').data('page') is 'CheckinsNew'
    #***********
    #LEAFLET JS
    #***********

    # defines the tile layers
    graphic = L.tileLayer('http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.jpg', {
    attribution: "<a href='http://stamen.com'>Stamen Design</a> <a href='http://creativecommons.org/licenses/by/3.0'>CC-BY-SA</a>"
    })
    midnight = L.tileLayer("http://{s}.tile.cloudmade.com/8fe4ccbb4940415d9475cc21bf41ea53/999/256/{z}/{x}/{y}.png", {attribution: '2011 CloudMade'})

    # creates a map in the "map" divset
    map = new L.map('map', {
      layers: [graphic]
      })

    # sets variable for the layers
    baseMaps = {
      "Day View": graphic,
      "Night View": midnight
    };

    #determines layer based on time of day


    #add manual controller for layer versions
    L.control.layers(baseMaps).addTo(map);

    # geolocates user
    map.locate setView: true, maxZoom: 16

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

    #sets marker with popup
    onLocationFound = (e) ->
      radius = e.accuracy / 2
      # If using custom markers, pass the marker image as an option to the marker, such as {icon: greenIcon}
      $('#checkin_latitude').val(e.latitude)
      $('#checkin_longitude').val(e.longitude)
      L.marker(e.latlng, draggable: true).addTo(map).bindPopup("You are within " + radius + " meters of this point").openPopup()
      # Creates radius circle beneath marker
      # L.circle(e.latlng, radius).addTo map
    map.on "locationfound", onLocationFound


    #raises error is cannot geolocate
    onLocationError = (e) ->
      alert e.message

    map.on "locationerror", onLocationError



