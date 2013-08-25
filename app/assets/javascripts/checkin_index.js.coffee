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

    $('#itemContainer').append list_item

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

      styledMapType = new google.maps.StyledMapType(STYLES, { name: 'Styled' })

      map = new google.maps.Map(document.getElementById("map"), mapOptions)

      map.mapTypes.set('Styled', styledMapType)

      map

    google.maps.event.addDomListener(window, 'load', initialize(6, STYLES))

    infowindow = new google.maps.InfoWindow

    map = initialize(bounds, STYLES)
    bounds = new google.maps.LatLngBounds()

    $.getJSON "/checkins.json", (data) ->
      index = 1
      $.each data.checkins, (index, checkin) ->
        addCheckinMarker checkin, map, bounds
        populateTimeLine checkin, index
        index +=1
      paginate()


