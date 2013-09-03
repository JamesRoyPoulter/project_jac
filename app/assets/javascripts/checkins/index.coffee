$ ()->

  $('.categoryChoice').click ()->
    $.each $(this).siblings('.categoryChoice'), (index, item)->
      cat = @.getAttribute('data-value')
      $(this).attr(
        'src',
        "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/#{cat}_icon_grey.png"
      )
    $(this).attr(
      'src',
      "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/#{$(this).data('value')}_icon_red.png"
    )
    $('#searchCategory').attr({value: $(this).data('value') })

  timelineDisplay = ()->
    screen_size = {
      width  : $(window).width(),
      height : $(window).height()
    }
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
      icon:
        if checkin.categories[0]?
          markerColor(checkin.categories[0].color)
        else
          Ehxe.markers.black
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
    if checkin.categories[0]?
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
    if checkin.image and checkin.image.length isnt 0
      $("<img/>",
        class: 'jpage_image checkin_image'
        src: checkin.image[0].media.show_checkin.url
      ).appendTo "#checkin_title"+index
      setCategoryColor(checkin, index)
    else if checkin.audio and checkin.audio.length isnt 0
      $('<img/>',
        class: 'jpage_image checkin_audio'
        src: Ehxe.defaults.audio
      ).appendTo "#checkin_title"+index
      setCategoryColor(checkin, index)
    # else if checkin.video and checkin.video.length isnt 0
    #   $('<img/>',
    #     class:'jpage_image checkin_video'
    #     src: checkin.video[0].media.video_thumb.url
    #     # style: 'height:175px;width:175px'
    #   ).appendTo "#checkin_title"+index
    #   setCategoryColor(checkin, index)
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
    map = ""
    initialize = (zoom, styles)->
      mapOptions =
        mapTypeControlOptions:
          mapTypeIds: [ 'Styled']
        center: new google.maps.LatLng(16.7758, 3.0094)
        zoom: zoom
        minZoom: 2
        mapTypeId: 'Styled'
      styledMapType = new google.maps.StyledMapType(STYLES, { name: 'Styled' })
      map = Ehxe.Maps.map "map", mapOptions
      map.mapTypes.set('Styled', styledMapType)
      map

    google.maps.event.addDomListener(window, 'load', initialize(2, STYLES))

    infowindow = new google.maps.InfoWindow

    bounds = new google.maps.LatLngBounds()

    dataMap = (data)->
      $.map data, (x)->
        return label: x.name, value: x.name

    $.getJSON "/checkins.json", (data)->
      index = 1
      if data.checkins.length > 0
        $.each data.checkins, (index, checkin)->
          addCheckinMarker checkin, map, bounds
          populateTimeLine checkin, index
          index +=1
        paginate()
      else
        $('.bottom_container').css('display', 'none')

    $( "#searchQuery" ).autocomplete
      source: (request, response)->
        category = $('#searchCategory').val()
        $.ajax
          url:
            switch category
              when 'People' then "/search/People"
              when 'Category' then "/search/Categories"
              when 'Location' then "http://ws.geonames.org/searchJSON"
          dataType:
            switch category
              when 'People', 'Category'
                "json"
              when 'Location' then 'jsonp'
          data:
            featureClass: "P"
            style: "full"
            maxRows: 12
            name_startsWith: request.term
          success: (data)->
            switch category
              when 'People' then response( dataMap(data) )
              when 'Category' then response( dataMap(data) )
              when 'Location'
                response(
                  $.map data.geonames, (item)->
                    return label: (item.name + ", " + item.countryName), value: item.name
                )
      select: (event,ui)->
        category = $('#searchCategory').val()
        switch category
          when 'People'
            url = 'People'
          when 'Category'
            url = 'Categories'
          when 'Location'
            url = 'Location'
        $.getJSON "/search/#{url}?name="+ui.item.label, (data)->
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
