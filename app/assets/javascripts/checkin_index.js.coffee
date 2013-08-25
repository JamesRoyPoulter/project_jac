$ ->
  
  addCheckinMarker = (checkin, map, bounds)->
    checkinLatLng = new google.maps.LatLng checkin.latitude, checkin.longitude
    marker = new google.maps.Marker
      position: checkinLatLng
      map: map
    bounds.extend(checkinLatLng)
    map.fitBounds(bounds)

  populateTimeLine = (checkin, index)->
    checkin_div = $("<div/>", class: 'checkin_category', id: 'checkin_category'+index, text: checkin.title)

    # POPULATE LINK TO SHOW PAGE
    anchor_tag = $('<a/>', { href: '/checkins/' + checkin.id, html: checkin_div })

    # CREATE CONTAINER DIVS
    $("<li/>", class: 'checkin', id: 'checkin'+index, html: anchor_tag).appendTo("#itemContainer")

    #  CHECK CHECKIN HAS MEDIA
    unless checkin.assets[0] is undefined
      # IF MEDIA PRESENT, APPEND TO CHECKIN DIV
      $("<img/>",
        class: 'checkin_image'
        id: 'checkin_image'+index
        src: checkin.assets[0].media.show_checkin.url
      ).appendTo "#checkin_category"+index

  paginate = ()->
    $("div.holder").jPages
      containerID: "itemContainer"
      # first       : false,
      # previous    : false,
      # next        : false,
      # last        : false,
      # # midRange    : 15,
      # links       : "blank"
      perPage : 5
      # startPage : 1
      # startRange : 1
      # midRange : 5
      # endRange : 1

  # INITIATE MAP
  if $('body').data('page') is 'CheckinsIndex'

    initialize = (zoom) ->
      mapOptions =
        center: new google.maps.LatLng(51.5072, -0.1275)
        zoom: zoom
        mapTypeId: google.maps.MapTypeId.ROADMAP

      map = new google.maps.Map(document.getElementById("map"), mapOptions)

    google.maps.event.addDomListener(window, 'load', initialize(5))

    map = initialize()
    bounds = new google.maps.LatLngBounds()

    $.getJSON "/checkins.json", (data) ->
      index = 1
      $.each data.checkins, (index, checkin) ->
        addCheckinMarker checkin, map, bounds
        populateTimeLine checkin, index
        index +=1
      paginate()
      
    $('#checkinsSearch').submit (e)->
      e.preventDefault
      query = $('#searchLocation').val()
      $.getJSON '/checkins/search/'+query, (data)->
        if data.checkins.length isnt 0
          index = 1
          $.each data.checkins, (index, checkin) ->
            addCheckinMarker checkin, map, bounds
            populateTimeLine checkin, index
            index += 1
        else
          alert 'No checkins near the location you have requested'

