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

STYLES = [
  {
    "featureType": "water",
    "stylers": [
      { "saturation": -8 },
      { "color": "#00009d" },
      { "hue": "#00eeff" }
    ]
  },{
    "featureType": "landscape.man_made",
    "elementType": "labels.text",
    "stylers": [
      { "hue": "#fff700" },
      { "saturation": -49 }
    ]
  },{
    "featureType": "road.highway",
    "stylers": [
      { "hue": "#ff3c00" },
      { "visibility": "simplified" }
    ]
  },{
    "elementType": "labels.text.fill",
    "stylers": [
      { "color": "#008080" },
      { "gamma": 0.82 }
    ]
  },{
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      { "visibility": "off" }
    ]
  },{
    "featureType": "road.arterial",
    "stylers": [
      { "hue": "#ffb300" }
    ]
  },{
    "featureType": "road.local",
    "elementType": "geometry",
    "stylers": [
      { "visibility": "on" },
      { "weight": 0.1 },
      { "hue": "#b300ff" }
    ]
  },{
    "featureType": "landscape.man_made",
    "stylers": [
      { "visibility": "on" },
      { "hue": "#ffff00" },
    ]
  },  {
    "featureType": "landscape.natural",
    "elementType": "geometry.fill",
    "stylers": [
      { "visibility": "on" },
      { "hue": "#fff700" },
      { "gamma": 0.89 },
      { "lightness": -11 },
      { "saturation": 72 }
    ]
  },{
    "featureType": "landscape.natural.landcover",
    "stylers": [
      { "saturation": 49 },
      { "hue": "#ff0022" },
      { "gamma": 1 },
      { "lightness": -8 }
    ]
  },{
    "featureType": "administrative",
    "stylers": [
      { "weight": 1.4 }
    ]
  },{
    "featureType": "administrative.province",
    "elementType": "geometry",
    "stylers": [
      { "visibility": "on" },
      { "gamma": 0.75 },
      { "weight": 1.3 },
      { "hue": "#ffe500" },
      { "color": "#727272" }
    ]
  },{
    "featureType": "road.highway",
    "elementType": "labels.icon",
    "stylers": [
      { "hue": "#fff700" },
      { "lightness": 21 },
      { "visibility": "on" }
    ]
  },{
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      { "visibility": "on" }
    ]
  },{
    "featureType": "poi.government",
    "elementType": "geometry",
    "stylers": [
      { "hue": "#00ff11" },
      { "saturation": -7 },
      { "gamma": 1.14 },
      { "lightness": 25 },
      { "color": "#7c9189" }
    ]
  },{
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      { "color": "#7d8080" }
    ]
  },{
    "featureType": "poi.park",
    "stylers": [
      { "saturation": 49 },
      { "gamma": 1 },
      { "lightness": -12 },
      { "hue": "#00ff91" }
    ]
  }
]
