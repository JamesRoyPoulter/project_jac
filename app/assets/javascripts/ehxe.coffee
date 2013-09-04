stopRKey = (evt) ->
  evt = (if (evt) then evt else ((if (event) then event else null)))
  node = (if (evt.target) then evt.target else ((if (evt.srcElement) then evt.srcElement else null)))
  false  if (evt.keyCode is 13) and (node.type is "text")

window.markerColor = (color) ->
  switch color
    when "aqua"
      Ehxe.markers.aqua
    when "black"
      Ehxe.markers.black
    when "blue"
      Ehxe.markers.blue
    when "coral"
      Ehxe.markers.coral
    when "green"
      Ehxe.markers.green
    when "mint"
      Ehxe.markers.mint
    when "pink"
      Ehxe.markers.pink
    when "purple"
      Ehxe.markers.purple
    when "red"
      Ehxe.markers.red
    when "yellow"
      Ehxe.markers.yellow
    else
      Ehxe.markers.black

navBar = $.jPanelMenu(
  menu: "#navbar"
  trigger: ".menu_icon"
  openPosition: "160px"
  closeOnContentClick: true
)

navBar.on()
$(".jPanelMenu-panel").css
  height: "100%"
  "min-height": "0"

document.onkeypress = stopRKey

window.Ehxe =
  markers:
    aqua: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/aqua_marker.png"
    black: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/black_marker.png"
    blue: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/blue_marker.png"
    coral: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/coral_marker.png"
    green: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/green_marker.png"
    mint: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/mint_marker.png"
    pink: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/pink_marker.png"
    purple: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/purple_marker.png"
    red: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/red_marker.png"
    yellow: "https://s3-eu-west-1.amazonaws.com/ehxe/markers/yellow_marker.png"

  marker_hex_values:
    aqua: "#48D7E4"
    black: "#000000"
    blue: "#3496FF"
    coral: "#F54054"
    green: "#3AAC00"
    mint: "#56FFAA"
    pink: "#F4007B"
    purple: "#B700CA"
    red: "#C40000"
    yellow: "#FBD300"

  defaults:
    map: "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/default_map.png"
    audio: "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/audio.png"
    x: "https://s3-eu-west-1.amazonaws.com/ehxe/defaults/x_icon.png"

  setFormLatLng: (lat, lng) ->
    $("#checkin_latitude").val lat
    $("#checkin_longitude").val lng

  previewImage: (element, input) ->
    if input and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $(element).eq(-1).attr "src", e.target.result
      reader.readAsDataURL input.files[0]

  getFileType: (file)->
    x = new RegExp(/^[a-zA-Z]*/)
    x.exec(file.files[0].type)[0]

  validateFileType: (type,element)->
    if type is 'image'
      Ehxe.previewImage(".upload_preview", element)
    else if type is 'audio'
      $('.upload_preview').eq(-1).attr("src",'https://s3-eu-west-1.amazonaws.com/ehxe/defaults/audio.png')
    else
      alert 'Invalid File Type'
      delete this.files[0]

  appendFileInput: (element)->
    $(element).append $('<div/>',
      class:'new_media'
      html: $('<img/>',{class: 'upload_preview'})
    ).append $('<input>',
      {type:'file', name: 'medias[]', class: 'checkin_medias' }
    )

  newCheckinPreviewImage: ()->
    Ehxe.appendFileInput('.assets_form')
    $('.checkin_medias').eq(-1).click()
    $('.checkin_medias').change ()->
      fileType = Ehxe.getFileType(this)
      Ehxe.validateFileType(fileType,this)
    $('.upload_preview').click ()->
      confirmation = confirm('Are you sure you want to delete this asset?')
      if confirmation is true
        $(this).parents('.new_media').remove()

  Maps:
    markersArray: []

    map: (element, options) ->
      new google.maps.Map(document.getElementById(element), options)

    mapOptions: (center, zoom) ->
      center: center
      zoom: zoom
      minZoom: 1
      mapTypeId: "Styled"
      mapTypeControlOptions:
        mapTypeIds: ["Styled"]

    styledMap: ()->
      new google.maps.StyledMapType STYLES, name: 'Styled'

    placeMarker: (location, map, color)->
      marker = new google.maps.Marker
        position: location
        icon: Ehxe.markers[color]
        map: map
      @markersArray.push marker

    checkinMarker: (location, map, color)->
      new google.maps.Marker
        position: location
        map: map
        draggable: true
        title: 'mark your life here X'
        icon: Ehxe.markers[color]

    clearMarkers: ()->
      for i in @markersArray
        i.setMap null
      @markersArray.length = 0

    markerSetByCategory: (marker)->
      $('#checkin_category_ids option').click (e)->
        $.getJSON '/categories/'+$(this).attr('value')+'.json', (data)->
          marker.icon = Ehxe.markers[data.category.color]


window.STYLES = [
  featureType: "water"
  stylers: [
    hue: "#3c00ff"
  ,
    color: "#808080"
  ]
,
  featureType: "water"
  elementType: "labels.text"
  stylers: [
    hue: "#ff00ee"
  ,
    weight: 0.1
  ,
    visibility: "on"
  ,
    color: "#cccccc"
  ]
,
  featureType: "poi.park"
  elementType: "geometry"
  stylers: [color: "#708080"]
,
  featureType: "road"
  elementType: "geometry"
  stylers: [
    hue: "#ff005d"
  ,
    saturation: -3
  ,
    color: "#000000"
  ,
    weight: 0.4
  ]
,
  featureType: "road"
  elementType: "labels.text"
  stylers: [hue: "#00bbff"]
,
  featureType: "landscape.natural.landcover"
  stylers: [color: "#ffffff"]
,
  featureType: "transit.line"
  stylers: [hue: "#00ddff"]
,
  featureType: "poi.government"
  elementType: "geometry"
  stylers: [
    hue: "#0000ff"
  ,
    color: "#9a8080"
  ]
,
  featureType: "poi.business"
  elementType: "geometry"
  stylers: [
    hue: "#ff0077"
  ,
    color: "#918080"
  ]
,
  featureType: "road.highway"
  elementType: "labels.icon"
  stylers: [
    lightness: 2
  ,
    gamma: 0.96
  ,
    hue: "#ffe500"
  ]
,
  featureType: "administrative"
  elementType: "labels.text.fill"
  stylers: [color: "#000000"]
,
  featureType: "poi.park"
  elementType: "labels.text"
  stylers: [
    hue: "#ff00ee"
  ,
    weight: 0.1
  ,
    visibility: "on"
  ,
    color: "#cccccc"
  ]
]
