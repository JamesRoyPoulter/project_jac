// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require jPages
//= require gmaps.js
//= require canvasjs.min
//= require chart
//= require_tree .

// GLOBAL VARIABLES

AUDIO_IMAGE = "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/default_map_icon.png"

STYLES = [
  {
    "featureType": "water",
    "stylers": [
      { "hue": "#3c00ff" },
      { "color": "#808080" }
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
  },{
  }
]