$ ->

  addCheckinMarker = (checkin, map, bounds)->
    checkinLatLng = new google.maps.LatLng checkin.latitude, checkin.longitude
    marker = new google.maps.Marker
      position: checkinLatLng
      map: map
    contentString = checkin.title
    google.maps.event.addListener(marker, 'click', ->
      infowindow.setContent(contentString)
      infowindow.open(map, marker))
    bounds.extend(checkinLatLng)
    map.fitBounds(bounds)

  # POPULATE CATEGORY
  populateTimeLine = (checkin, index)->
    checkin_div = $("<div/>", class: 'checkin_category', id: 'checkin_category'+index, text: checkin.title)

    # POPULATE LINK TO SHOW PAGE IN CHECKIN DIV
    anchor_tag = $('<a/>', { href: '/checkins/' + checkin.id, html: checkin_div })

    # CREATE CONTAINER DIVS
    list_item = $("<li/>", class: 'checkin', id: 'checkin'+index, html: anchor_tag)

    #  CHECK CHECKIN HAS MEDIA
    unless checkin.assets[0] is undefined
        # IF MEDIA PRESENT, APPEND TO CHECKIN DIV
        $("<img/>",
          class: 'checkin_image'
          id: 'checkin_image'+index
          src: checkin.assets[0].media.show_checkin.url
        ).appendTo "#checkin_category"+index

    $('#itemContainer').append list_item

  paginate = ()->
    $(".holder").jPages
      containerID: "itemContainer"
      # first       : false,
      previous    : false,
      next        : false,
      # last        : false,
      # # midRange    : 15,
      links       : "blank"
      perPage : 5
      # startPage : 1
      # startRange : 1
      # midRange : 5
      # endRange : 1

  # INITIATE MAP
  if $('body').data('page') is 'CheckinsIndex'
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

    $('#checkinsSearch').submit (e)->
      e.preventDefault
      query = $('#searchLocation').val()
      $('#searchLocation').val ''
      $.getJSON '/checkins/search/'+query, (data)->
        if data.checkins.length isnt 0
          index = 1
          $.each data.checkins, (index, checkin) ->
            addCheckinMarker checkin, map, bounds
            populateTimeLine checkin, index
            index += 1
        else
          alert 'No checkins near the location you have requested'

    initialize = (zoom, styles) ->
      mapOptions =
        mapTypeControlOptions:
          mapTypeIds: [ 'Styled']
        center: new google.maps.LatLng(51.0500, 3.7333)
        zoom: zoom
        mapTypeId: 'Styled'

      styledMapType = new google.maps.StyledMapType(styles, { name: 'Styled' })

      map = new google.maps.Map(document.getElementById("map"), mapOptions)

      map.mapTypes.set('Styled', styledMapType)

      map

    google.maps.event.addDomListener(window, 'load', initialize(6, styles))

    infowindow = new google.maps.InfoWindow

    map = initialize(bounds, styles)
    bounds = new google.maps.LatLngBounds()

    $.getJSON "/checkins.json", (data) ->
      index = 1
      $.each data.checkins, (index, checkin) ->
        addCheckinMarker checkin, map, bounds
        populateTimeLine checkin, index
        index +=1
      paginate()

