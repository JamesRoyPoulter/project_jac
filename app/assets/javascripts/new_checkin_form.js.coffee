media_divs_length = 0

$ ()->

  $('.category_overlay').click () ->
    $(@).hide()
    $('.category_content').show()
    autoOpenCategoryChoice()

  $('.people_overlay').click () ->
    $(@).hide()
    $('.people_content').show()
    autoOpenPeopleChoice()

  $('.words_overlay').click () ->
    $(@).hide()
    $('.words_content').show()
    autoOpenWordsChoice()

# Not console-logging or re-showing text div on click...
  # $('.remove_nested_fields').click () ->
  #   console.log "meow"
  #   $('.words_overlay').show()

  $('.add_media_overlay').click () ->
    $(@).hide()
    $('.add_media').show()
    addMedia()
    autoOpenMediaChoice()

  $('#add_media').click ()->
    addMedia()

  addMedia = () ->
    $('.div_for_asset__upload_appends').append $('<div/>',
      class:'new_media'
      html: $('<input>',
        type:'file'
        name: 'medias[]'
        id: 'checkin_medias'
      )
    ).append $('<img/>',
      src: DEFAULT_X,
      class: 'x_icon')

    $('.x_icon').click ()->
      $(@).parent('.new_media').remove()

    media_divs_length += 1
    if media_divs_length>=5
      $('#add_media').hide()

  autoOpenMediaChoice = () ->
    $('#checkin_medias').trigger('click');

  autoOpenCategoryChoice = () ->
    $('#auto_open_id').trigger('click');

  autoOpenPeopleChoice = () ->
    $('#auto_open_people_id').trigger('click');

  autoOpenWordsChoice = () ->
    $('#add_words_link').trigger('click');
    $('#add_words_link').hide()





if $('body').data('page') is 'CheckinsNew'
  #gets location from browser
  getLocation = ()->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition assignPositionToForm
    else
      x.innerHTML = 'Geolocation is not supported by this browser.'

  #assigns location to hidden form fields
  assignPositionToForm = (position)->
    $('#checkin_latitude').val position.coords.latitude
    $('#checkin_longitude').val position.coords.longitude

    #sets lat and lng to current location
    myLatlng = new google.maps.LatLng position.coords.latitude, position.coords.longitude

    #assigns map options using current location and styles
    mapOptions =
      center: myLatlng
      zoom: 16
      minZoom: 1
      mapTypeId: 'Styled'
      mapTypeControlOptions:
        mapTypeIds: ['Styled']

    styledMapType = new google.maps.StyledMapType STYLES, name: 'Styled'

    #generates the map, passing options and style
    map = new google.maps.Map document.getElementById("map"), mapOptions
    map.mapTypes.set 'Styled', styledMapType

    #creates the geolocated marker
    marker = new google.maps.Marker
      position: myLatlng
      map: map
      draggable: true
      title: 'mark your life here X'
      icon: 'https://s3-eu-west-1.amazonaws.com/ehxe/markers/exhe_marker_black_little.png'

    #creates check-in info-window
    infowindow = new google.maps.InfoWindow
      content: 'mark your life here'

    google.maps.event.addListener marker, 'dragend', ()->
      position = marker.getPosition()
      $('#checkin_latitude').val position.lat()
      $('#checkin_longitude').val position.lng()

    google.maps.event.addListener marker, 'click', ()->
      infowindow.open map, marker

  google.maps.event.addDomListener window, 'load', getLocation

