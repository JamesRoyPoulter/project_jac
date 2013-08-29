$ ()->
  addCheckinMarker = (checkin, map, bounds)->
    checkinLatLng = new google.maps.LatLng checkin.latitude, checkin.longitude
    marker = new google.maps.Marker
      position: checkinLatLng
      map: map
      icon: ICON
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

  # CREATE CHART FOR PEOPLE
  # window.onload = () ->
  #   chart = new CanvasJS.Chart("chartContainer",
  #     data: [
  #       {
  #         type: "stackedBar100"
  #         showInLegend: false
  #         dataPoints: [
  #           {
  #             y: 350
  #             label: "Lobby Chair"
  #           }]
  #       },
  #      {
  #       type: "stackedBar100"
  #       showInLegend: false
  #       dataPoints: [
  #         {
  #           y: 450
  #           label: "Lobby Chair"
  #         }]
  #     },
  #     {
  #       type: "stackedBar100"
  #       showInLegend: false
  #       dataPoints: [
  #         {
  #           y: 340,
  #           label: "Lobby Chair"
  #         }]
  #     }
  #     ]
  #   )
  #   chart.render()

  # generate_static_url = (checkin, map) ->
  #   GMaps.staticMapURL
  #     size: [175, 175]
  #     zoom: 6
  #     style:"feature:water|element:undefined|saturation:-8|color:0x00009d|hue:0x00eeff"
  #     lat: checkin.latitude
  #     lng: checkin.longitude
  #     mapType: 'Styled'
  #     markers: [
  #       icon: 'http://tinyurl.com/mhoqu4d'
  #       lat: checkin.latitude
  #       lng: checkin.longitude
  #     ]


  # POPULATE CATEGORY
  populateTimeLine = (checkin, index)->
    checkin_title = $("<div/>", class: 'checkin_title', id: 'checkin_title'+index, text: checkin.title)

    # POPULATE LINK TO SHOW PAGE IN CHECKIN DIV
    anchor_tag = $('<a/>', { href: '/checkins/' + checkin.id, html: checkin_title })

    # CREATE CONTAINER DIVS
    list_item = $("<li/>", class: 'checkin', id: 'checkin'+index, html: anchor_tag)

    $('#itemContainer').append list_item

    # Iterate Through Checkin's Assets
    assets = checkin.seperated_assets
    if assets['image'].length isnt 0
      $("<img/>",
        class: 'checkin_image'
        id: 'checkin_image'+index
        src: assets['image'][0].media.show_checkin.url
      ).appendTo "#checkin_title"+index
    else if assets['audio'].length isnt 0
      $('<img/>',
        class: 'checkin_audio'
        id: 'checkin_audio' + index
        src: AUDIO_IMAGE
        style: 'height:175px;width:175px'
      ).appendTo "#checkin_title"+index
    else if assets['video'].length isnt 0
      $('<img/>',
        class:'checkin_video'
        id: 'checkin_video' + index
        src: assets['video'][0].media.video_thumb.url
        style: 'height:175px;width:175px'
      ).appendTo "#checkin_title"+index
    else if assets['text'].length isnt 0
      $('<p/>',
        class: 'checkin_words'
        id: 'checkin_words' + index
        html: assets['text'][0].words
      ).appendTo "#checkin_title"+index
    else
      $("<img/>",
        class: 'checkin_minimap'
        id: 'checkin_minimap'+index
        src: 'https://s3-eu-west-1.amazonaws.com/ehxe/defaults/default_map_icon.png'
      ).appendTo "#checkin_title"+index


  paginate = ()->
    $(".holder").jPages
      containerID: "itemContainer"
      previous: false,
      next: false,
      links: "blank",
      perPage: 5,
      keybrowse: true,
      scrollbrowse: true

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

    multipartJSON = ()->
      $.getJSON '/search/people?name_startsWith='+ui.item.label, (data)->
        if data.people[0].checkins.length isnt 0
          $('#itemContainer').html ''
          index = 1
          clearMarkers markersArray
          markersArray.length = 0
          $.each data.people[0].checkins, (index, checkin)->
            addCheckinMarker checkin, map, bounds
            populateTimeLine checkin, index
            index += 1
          map.setCenter markersArray[0].position
          map.setZoom 10
          paginate()
        else
          alert 'You have no checkins with this person'

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
              when 'people'
                response(
                  $.map data.people, (person)->
                    return label: person.name, value: person.name
                )
              when 'category'
                response(
                  $.map data.categories, (category)->
                    return label: category.name, value: category.name
                )
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
