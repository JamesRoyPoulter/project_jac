$ ->

  # INITIATE MAP
  if $('body').data('page') is 'CheckinsIndex'

    initialize = (zoom) ->
      mapOptions =
        center: new google.maps.LatLng(51.5072, -0.1275)
        zoom: zoom
        mapTypeId: google.maps.MapTypeId.ROADMAP

      map = new google.maps.Map(document.getElementById("map"), mapOptions)

    google.maps.event.addDomListener(window, 'load', initialize(5))

    $("#show_checkins_map").click ->
      $.getJSON "/checkins.json", (data) ->

        map = initialize()
        bounds = new google.maps.LatLngBounds()

        # DECLARE INDEX VALUE
        index = 1

        # ITERATE THROUGH JSON OBJECT
        $.each data.checkins, (index, checkin) ->
          checkinLatLng = new google.maps.LatLng checkin.latitude, checkin.longitude
          marker = new google.maps.Marker
            position: checkinLatLng
            map: map
          bounds.extend(checkinLatLng)
          map.fitBounds(bounds)

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
          unless checkin.assets[0] is undefined

            # IF MEDIA PRESENT, APPEND TO CHECKIN DIV
            $("<img/>",
              class: 'checkin_image'
              id: 'checkin_image'+index
              src: checkin.assets[0].media.show_checkin.url
            ).appendTo "#checkin_category"+index


          index +=1


