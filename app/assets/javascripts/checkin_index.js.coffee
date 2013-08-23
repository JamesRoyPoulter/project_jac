$ ->
  if $('body').data('page') is 'CheckinsIndex'
    checkin_map = undefined
    checkin_map = L.map("map",
      center: [51.505, -0.09]
      zoom: 11
    )
    L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
      attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    ).addTo checkin_map
    $("#show_checkins_map").click ->
      $.getJSON "/checkins.json", (data) ->

        # DECLARE INDEX VALUE
        index = 1

        # ITERATE THROUGH JSON OBJECT
        $.each data.checkins, (index, checkin) ->

          # POPULATE MAP
          latlong = undefined
          marker = undefined
          latlong = new L.LatLng(parseFloat(checkin.latitude), parseFloat(checkin.longitude))
          marker = new L.marker(latlong)
          marker.data = checkin
          checkin_map.addLayer marker.bindPopup(checkin.title)

          # POPULATE TIMELINE
          # CREATE DIVS
          $("<div/>",
            class: 'checkin'
            id: 'checkin'+index
          ).appendTo("#timeline")

          # POPULATE CATEGORY
          $("<div/>",
            class: 'checkin_category'
            id: 'checkin_category'+index
            text: checkin.category
          ).appendTo "#checkin" + index

          #  CHECK CHECKIN HAS MEDIA
          if checkin.asset[0].media isnt undefined

            # IF MEDIA PRESENT, APPEND TO ABOVE DIV
            $("<img/>",
              class: 'checkin_image'
              id: 'checkin_image'+index
              src: checkin.asset[0].media.show_checkin.url
            ).appendTo "#checkin_category"+index
            # $("#checkin"+index).append "<img src='" + checkin.asset[0].media.show_checkin.url + "'/>"

          index +=1

