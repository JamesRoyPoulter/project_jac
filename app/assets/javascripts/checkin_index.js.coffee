$ ->
  addCheckinMarker = (checkin, map, bounds)->
    checkinLatLng = new google.maps.LatLng checkin.latitude, checkin.longitude
    marker = new google.maps.Marker
      position: checkinLatLng
      map: map
      icon: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_black_little.png'
      contentString = checkin.title
    google.maps.event.addListener(marker, 'click', ->
      infowindow.setContent(contentString)
      infowindow.open(map, marker))
    markersArray.push marker
    bounds.extend(checkinLatLng)
    map.fitBounds(bounds)

# CREATE CHART FOR PEOPLE
  # createChart = () ->
  #   chart = new CanvasJS.Chart("chartContainer",
  #     title:
  #       text: "Categories with friends"

  #     data: [
  #       type: "stackedBar100"
  #       dataPoints: [
  #         y: 600
  #         label: "Water Filter",
  #         y: 400
  #         label: "Modern Chair",
  #         y: 120
  #         label: "VOIP Phone",
  #         y: 250
  #         label: "Microwave",
  #         y: 120
  #         label: "Water Filter",
  #         y: 374
  #         label: "Expresso Machine",
  #         y: 350
  #         label: "Lobby Chair"
  #       ]
  #     ]
  #   )
  #   chart.render()

  generate_static_url = (checkin) ->
    url = "http://maps.googleapis.com/maps/api/staticmap?"
    params = []
    params.push "center=" + map.getCenter().toUrlValue()
    params.push "zoom=" + map.getZoom()
    params.push "format=png"
    params.push "sensor=false"
    params.push "size=175x175"
    params.push "maptype=" + map.getMapTypeId()
    params.push "markers=icon:http://tinyurl.com/mhoqu4d|" + checkin.latitude + ',' + checkin.longitude
    params.push "visual_refresh=true"  if google.maps.visualRefresh
    i = 0

    while i < STYLES.length
      styleRule = []
      styleRule.push "feature:" + STYLES[i].featureType  unless STYLES[i].featureType is "all"
      styleRule.push "element:" + STYLES[i].elementType  unless STYLES[i].elementType is "all"
      j = 0

      while j < STYLES[i].stylers.length
        for p of STYLES[i].stylers[j]
          ruleArg = STYLES[i].stylers[j][p]
          ruleArg = "0x" + ruleArg.substring(1)  if p is "hue" or p is "color"
          styleRule.push p + ":" + ruleArg
        j++
      rule = styleRule.join("|")
      params.push "style=" + rule  unless rule is ""
      i++
    url + params.join("&")



  # POPULATE CATEGORY
  populateTimeLine = (checkin, index)->
    checkin_title = $("<div/>", class: 'checkin_title', id: 'checkin_title'+index, text: checkin.title)

    # POPULATE LINK TO SHOW PAGE IN CHECKIN DIV
    anchor_tag = $('<a/>', { href: '/checkins/' + checkin.id, html: checkin_title })

    # CREATE CONTAINER DIVS
    list_item = $("<li/>", class: 'checkin', id: 'checkin'+index, html: anchor_tag)

    $('#itemContainer').append list_item

     # CHECK CHECKIN HAS MEDIA
    if checkin.assets[0] is undefined
      $("<img/>",
        class: 'checkin_minimap'
        id: 'checkin_minimap'+index
        src: generate_static_url(checkin)
      ).appendTo "#checkin_title"+index
    else if checkin.assets[0].file_type is 'image'
      $("<img/>",
        class: 'checkin_image'
        id: 'checkin_image'+index
        src: checkin.assets[0].media.show_checkin.url
      ).appendTo "#checkin_title"+index
    else if checkin.assets[0].file_type is 'audio'
      $("<audio/>",
        class: 'checkin_image'
        id: 'checkin_image'+index
        src: checkin.assets[0].media.url
      ).appendTo "#checkin_title"+index
    else
      console.log(checkin.assets[0].file_type)
        # IF MEDIA PRESENT, APPEND TO CHECKIN DIV
      $("<div/>",
        class: 'checkin_words'
        id: 'checkin_words'+index
        html: checkin.assets[0].words
      ).appendTo "#checkin_title"+index

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

  markersArray = []

  clearMarkers = (markersArray)->
    if markersArray
      for i in markersArray
        i.setMap null

  # INITIATE MAP
  if $('body').data('page') is 'CheckinsIndex'

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

    google.maps.event.addDomListener(window, 'load', initialize(10, STYLES))

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

    $('#checkinsSearch').submit (e)->
      e.preventDefault
      query = $('#searchCatgory').val() + '/' + $('#searchLocation').val()

      $('#searchLocation').val ''
      $('#itemContainer').html ''

      $.getJSON '/checkins/search/'+query, (data)->
        console.log data
        if data.checkins.length isnt 0
          index = 1
          clearMarkers markersArray
          markersArray.length = 0
          $.each data.checkins, (index, checkin) ->
            addCheckinMarker checkin, map, bounds
            populateTimeLine checkin, index
            index += 1
          map.setCenter markersArray[0].position
          map.setZoom 10
          paginate()
        else
          alert 'No checkins near the location you have requested'


