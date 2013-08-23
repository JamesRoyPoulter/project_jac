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
        $.each data.checkins, (index, checkin) ->
          latlong = undefined
          marker = undefined
          latlong = new L.LatLng(parseFloat(checkin.latitude), parseFloat(checkin.longitude))
          marker = new L.marker(latlong)
          marker.data = checkin
          checkin_map.addLayer marker.bindPopup(checkin.title)
          timeline = $("<div/>",
            id: "category"
            text: checkin.category
          ).appendTo("#category")
          if checkin.asset[0].media isnt undefined
            $("<img/>",
              id: "asset"
              src: checkin.asset[0].media.url
            ).appendTo "#asset"
            $("#category").append "<img src='" + checkin.asset[0].media.url + "'/>"



