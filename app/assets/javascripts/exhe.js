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

var Exhe = {
  marker_base: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_',
  markers: {
    black: .marker_base + 'black_little.png'
  }
}

DEFAULT_MAP = 'https://s3-eu-west-1.amazonaws.com/ehxe/defaults/default_map_icon.png'
DEFAULT_X = "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/x_icon.png"
AUDIO_IMAGE = "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/audio.png"

function markerColor(color) {
  url = 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_'
  switch (color) {
    case 'red':
      url += 'red.png'
    case 'coral':
      url +=  'coral.png'
    case 'crimson':
      url += 'crimson_little.png'
    case 'green':
      url += 'green.png'
    case 'mustard':
      url += 'mustard.png'
    case 'pink':
      url += 'pink.png'
    case 'purple':
      url += 'purple.png'
    default:
      url += 'black_little.png'
  }
  return url
}

ICON = 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_black_little.png'

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
