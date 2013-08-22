$(function() {
  var checkin_map;
  checkin_map = L.map('map', {
    center: [51.505, -0.09],
    zoom: 11
  });
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(checkin_map);
  return $('#show_checkins_map').click(function() {
    return $.getJSON("/checkins.json", function(data) {
      return $.each(data.checkins, function(index, checkin) {
        var latlong, marker;
        latlong = new L.LatLng(parseFloat(checkin.latitude), parseFloat(checkin.longitude));
        marker = new L.marker(latlong);
        marker.data = checkin;
        checkin_map.addLayer(marker.bindPopup(checkin.title));
         console.log(checkin.category);
          timeline = $('<div/>', {
            id: 'category',
            text: checkin.category
          }).appendTo('#category');
          if (checkin.asset[0].media !== void 0) {
            console.log(checkin.asset[0].media.url);
            $('<img/>', {
              id: 'asset',
              src: checkin.asset[0].media.url
            }).appendTo('#asset');
            return $('#category').append("<img src='" + checkin.asset[0].media.url + "'/>");
          }
      });
    });
  });
});