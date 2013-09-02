$ ()->

  # $('.select_search_div').click () ->


  timelineDisplay = ()->
    screen_size = {
      width  : $(window).width(),
      height : $(window).height()
    }
    console.log(screen_size.width)
    w = screen_size.width
    if w < 410
      num = 3
    else if w > 411 and w < 640
      num = 4
    else if w > 641 and w < 800
      num = 5
    else if w > 801 and w < 1100
      num = 6
    else if w > 1101
      num = 7
    return num

  widthFunction = () ->
    timeline_div_width = String(100/timelineDisplay().toFixed(2) + '%')
    return timeline_div_width

  addCheckinMarker = (checkin, map, bounds)->
    checkinLatLng = new google.maps.LatLng checkin.latitude, checkin.longitude
    marker = new google.maps.Marker
      position: checkinLatLng
      map: map
      icon: markerColor(checkin.categories[0].color)
      contentString = checkin.title
    google.maps.event.addListener(marker, 'click', ()->
      infowindow.setContent(contentString)
      infowindow.open(map, marker))
    markersArray.push marker
    bounds.extend(checkinLatLng)
    if markersArray[0] is marker
      map.setZoom(13)
      map.setCenter(checkinLatLng)
    else
      map.fitBounds(bounds)

  setCategoryColor = (checkin, index)->
    category_color =  checkin.categories[0].color
    $('<div/>',
      class:'jpage_category_bar'
      style: 'background-color:'+Ehxe.marker_hex_values[category_color]
    ).appendTo '#checkin_title'+index

  # POPULATE CATEGORY
  populateTimeLine = (checkin, index)->

    checkin_title = $("<div/>", class: 'checkin_title', id: 'checkin_title'+index)

    # POPULATE LINK TO SHOW PAGE IN CHECKIN DIV
    anchor_tag = $('<a/>', { href: '/checkins/' + checkin.id, html: checkin_title })

    # CREATE CONTAINER DIVS
    list_item = $("<li/>", class: 'checkin', id: 'checkin'+index, style: 'width:'+widthFunction(), html: anchor_tag)
    $('#itemContainer').append list_item

    # Iterate Through Checkin's Assets
    assets = checkin.seperated_assets
    if assets['image'] and assets['image'].length isnt 0
      $("<img/>",
        class: 'jpage_image checkin_image'
        src: assets['image'][0].media.show_checkin.url
      ).appendTo "#checkin_title"+index
      setCategoryColor(checkin, index)
    else if assets['audio'] and assets['audio'].length isnt 0
      $('<img/>',
        class: 'jpage_image checkin_audio'
        src: Ehxe.defaults.audio
      ).appendTo "#checkin_title"+index
      setCategoryColor(checkin, index)
    else if assets['video'] and assets['video'].length isnt 0
      $('<img/>',
        class:'jpage_image checkin_video'
        src: assets['video'][0].media.video_thumb.url
        # style: 'height:175px;width:175px'
      ).appendTo "#checkin_title"+index
      setCategoryColor(checkin, index)
    else if assets['text'] and assets['text'].length isnt 0
      $('<p/>',
        class: 'jpage_image checkin_words'
        html: assets['text'][0].words
      ).appendTo "#checkin_title"+index
      setCategoryColor(checkin, index)
    else
      $("<img/>",
        class: 'jpage_image checkin_minimap'
        src: Ehxe.defaults.map
      ).appendTo "#checkin_title"+index
      setCategoryColor(checkin, index)

  paginate = ()->
    $("ul li img").lazyload
      event : "turnPage",
      effect : "fadeIn"

    $(".holder").jPages
      containerID: "itemContainer"
      first: false,
      previous: false,
      next: false,
      last: false,
      links: "blank",
      midRange: 50,
      perPage: timelineDisplay(),
      keybrowse: true,
      scrollbrowse: true,
      animation   : "fadeInUp",
      callback: (pages, items) ->
        # lazy load current images
        items.showing.find("img").trigger "turnPage"
        # lazy load next page images
        items.oncoming.find("img").trigger "turnPage"


  markersArray = []

  clearMarkers = (markersArray)->
    if markersArray
      for i in markersArray
        i.setMap null

  # INITIATE MAP
  if $('body').data('page') is 'CheckinsIndex'

    initialize = (zoom, styles)->
      mapOptions =
        mapTypeControlOptions:
          mapTypeIds: [ 'Styled']
        center: new google.maps.LatLng(51.0500, 3.7333)
        zoom: zoom
        minZoom: 1
        mapTypeId: 'Styled'
      styledMapType = new google.maps.StyledMapType(STYLES, { name: 'Styled' })
      map = new google.maps.Map(document.getElementById("map"), mapOptions)
      map.mapTypes.set('Styled', styledMapType)
      map

    google.maps.event.addDomListener(window, 'load', initialize(10, STYLES))

    infowindow = new google.maps.InfoWindow

    map = initialize(bounds, STYLES)
    bounds = new google.maps.LatLngBounds()

    dataMap = (data)->
      $.map data, (x)->
        return label: x.name, value: x.name

    $.getJSON "/checkins.json", (data)->
      index = 1
      $.each data.checkins, (index, checkin)->
        addCheckinMarker checkin, map, bounds
        populateTimeLine checkin, index
        index +=1
      paginate()

    $( "#searchQuery" ).autocomplete
      source: (request, response)->
        category = $('#searchCategory').val()
        $.ajax
          url:
            switch category
              when 'people' then "/people"
              when 'category' then "/categories"
              when 'location' then "http://ws.geonames.org/searchJSON"
          dataType:
            switch category
              when 'people', 'category'
                "json"
              when 'location' then 'jsonp'
          data:
            featureClass: "P"
            style: "full"
            maxRows: 12
            name_startsWith: request.term
          success: (data)->
            switch category
              when 'people' then response( dataMap(data.people) )
              when 'category' then response( dataMap(data.categories) )
              when 'location'
                response(
                  $.map data.geonames, (item)->
                    return label: (item.name + ", " + item.countryName), value: item.name
                )
      select: (event,ui)->
        category = $('#searchCategory').val()
        $.getJSON "/search/#{category}?name_startsWith="+ui.item.label, (data)->
          if data.length isnt 0
            $('#itemContainer').html ''
            index = 1
            clearMarkers markersArray
            markersArray.length = 0
            $.each data, (index, checkin)->
              addCheckinMarker checkin, map, bounds
              populateTimeLine checkin, index
              index += 1
            map.setCenter markersArray[0].position
            map.setZoom 10
            paginate()
          else
            alert 'No Results Found'
