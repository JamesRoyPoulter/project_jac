$ ->

  # INITIATE MAP
  if $('body').data('page') is 'CheckinsIndex'

    $.getJSON "/checkins.json", (data) ->
      # DECLARE INDEX VALUE
      index = 1
      
      initialize = () ->
	      mapOptions =
	        center: new google.maps.LatLng(51.5072, -0.1275)
	        zoom: 5
	        mapTypeId: google.maps.MapTypeId.ROADMAP

	      map = new google.maps.Map(document.getElementById("map"), mapOptions)

      google.maps.event.addDomListener(window, 'load', initialize)

      # ITERATE THROUGH JSON OBJECT
      $.each data.checkins, (index, checkin) ->
        # marker = new google.maps.Marker
        #   position: new google.maps.LatLng checkin.latitude, checkin.longitude
        #   map: map


        # POPULATE TIMELINE

        # INITIATE JPAGES
        $ ->
          $("div.holder").jPages
            containerID: "itemContainer"
            # first       : false,
            # previous    : false,
            # next        : false,
            # last        : false,
            # # midRange    : 15,
            # links       : "blank"
            perPage : 2
            # startPage : 1
            # startRange : 1
            # midRange : 5
            # endRange : 1

        # POPULATE CATEGORY
        checkin_div = $("<div/>",
          class: 'checkin_category'
          id: 'checkin_category'+index
          text: checkin.category
        )

        # POPULATE LINK TO SHOW PAGE
        anchor_tag = $('<a/>', { href: '/checkins/' + checkin.id, html: checkin_div })

        # CREATE CONTAINER DIVS
        $("<li/>",
          class: 'checkin'
          id: 'checkin'+index,
          html: anchor_tag
          # html: $('<a/>', { href: '/checkins/' + checkin.id })
        ).appendTo("#itemContainer")

        #  CHECK CHECKIN HAS MEDIA
        if checkin.assets[0].media isnt undefined

          # IF MEDIA PRESENT, APPEND TO CHECKIN DIV
          $("<img/>",
            class: 'checkin_image'
            id: 'checkin_image'+index
            src: checkin.assets[0].media.show_checkin.url
          ).appendTo "#checkin_category"+index


        index +=1


