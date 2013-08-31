var navBar = $.jPanelMenu({
  menu: '#navbar',
  trigger: '.menu_icon',
  openPosition: '120px',
  closeOnContentClick: true
});

navBar.on();

function stopRKey(evt) {
  var evt = (evt) ? evt : ((event) ? event : null);
  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
  if ((evt.keyCode == 13) && (node.type=="text"))  {return false;}
}

document.onkeypress = stopRKey;

var Ehxe = {
  markers: {
    aqua: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/aqua_marker.png',
    black: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/black_marker.png',
    blue: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/blue_marker.png',
    coral: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/coral_marker.png',
    green: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/green_marker.png',
    mint: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/mint_marker.png',
    pink: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/pink_marker.png',
    purple: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/purple_marker.png',
    red: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/red_marker.png',
    yellow: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/yellow_marker.png',
  },
  defaults: {
    map: 'https://s3-eu-west-1.amazonaws.com/ehxe/defaults/default_map.png',
    audio: "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/audio.png",
    x: "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/x_icon.png"
  },
  setFormLatLng: function(lat,lng) {
    $('#checkin_latitude').val(lat)
    $('#checkin_longitude').val(lng)
  }
}

function markerColor(color) {
  switch (color) {
    case 'aqua':
      return Ehxe.markers.aqua
    case 'black':
      return Ehxe.markers.black
    case 'blue':
      return Ehxe.markers.blue
    case 'coral':
      return Ehxe.markers.coral
    case 'green':
      return Ehxe.markers.green
    case 'mint':
      return Ehxe.markers.pink
    case 'pink':
      return Ehxe.markers.purple
    case 'red':
      return Ehxe.markers.red
    case 'yellow':
      return Ehxe.markers.yellow
    default:
      return Ehxe.markers.black
  }
}

STYLES = [
  {
    "featureType": "water",
    "stylers": [
      { "hue": "#3c00ff" },
      { "color": "#808080" }
    ]
  },{
    "featureType": "water",
    "elementType": "labels.text",
    "stylers": [
      { "hue": "#ff00ee" },
      { "weight": 0.1 },
      { "visibility": "on" },
      { "color": "#cccccc" }
    ]
  },{
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      { "color": "#708080" }
    ]
  },{
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      { "hue": "#ff005d" },
      { "saturation": -3 },
      { "color": "#000000" },
      { "weight": 0.4 }
    ]
  },{
    "featureType": "road",
    "elementType": "labels.text",
    "stylers": [
      { "hue": "#00bbff" }
    ]
  },{
    "featureType": "landscape.natural.landcover",
    "stylers": [
      { "color": "#ffffff" }
    ]
  },{
    "featureType": "transit.line",
    "stylers": [
      { "hue": "#00ddff" }
    ]
  },{
    "featureType": "poi.government",
    "elementType": "geometry",
    "stylers": [
      { "hue": "#0000ff" },
      { "color": "#9a8080" }
    ]
  },{
    "featureType": "poi.business",
    "elementType": "geometry",
    "stylers": [
      { "hue": "#ff0077" },
      { "color": "#918080" }
    ]
  },{
    "featureType": "road.highway",
    "elementType": "labels.icon",
    "stylers": [
      { "lightness": 2 },
      { "gamma": 0.96 },
      { "hue": "#ffe500" }
    ]
  },{
    "featureType": "administrative",
    "elementType": "labels.text.fill",
    "stylers": [
      { "color": "#000000" }
    ]
  }, {
    "featureType": "poi.park",
    "elementType": "labels.text",
    "stylers": [
      { "hue": "#ff00ee" },
      { "weight": 0.1 },
      { "visibility": "on" },
      { "color": "#cccccc" }
    ]
  }
]
