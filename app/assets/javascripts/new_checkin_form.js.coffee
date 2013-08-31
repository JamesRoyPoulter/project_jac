restrictAddNumber = 0

$ ()->

if $('body').data('page') is 'CheckinsNew' || $('body').data('page') is 'CheckinsPast'
  $('.category_overlay').click () ->
    $(@).hide()
    $('.category_content').show()
    autoOpenCategoryChoice()

  addPeople = () ->
    $('.people_overlay').click () ->
      $(@).hide()
      $('.people_content').show()
      autoOpenPeopleChoice()

    restrictAddNumber += 1
    if restrictAddNumber>=5
      $('#add_people').hide()

  $('.words_overlay').click () ->
    $(@).hide()
    $('.words_content').show()
    autoOpenWordsChoice()

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
      html: $('<img/>',
        class: 'upload_preview'
        style: 'height: 50px'
      )
    ).append $('<input>',
        type:'file'
        name: 'medias[]'
        class: 'checkin_medias'
        style:'display:none'
      ).append $('<img/>',
        src: Ehxe.defaults.x,
        class: 'x_icon'
      )
      $('.checkin_medias').eq(-1).click()

    previewImage = (input)->
      if input && input.files[0]
        reader = new FileReader
        reader.onload = (e)->
          $(".upload_preview").eq(-1).attr "src", e.target.result
        reader.readAsDataURL input.files[0]

    $('.checkin_medias').change ()->
      previewImage(this)


    $('.x_icon').click ()->
      $(@).parent('.new_media').remove()

    restrictAddNumber += 1
    if restrictAddNumber>=5
      $('#add_media').hide()

  autoOpenCategoryChoice = () ->
    $('#auto_open_id').trigger('click')

  autoOpenPeopleChoice = () ->
    $('#auto_open_people_id').trigger('click')

  autoOpenWordsChoice = () ->
    $('#add_words_link').trigger('click')
    $('#add_words_link').hide()

#MAPPING BELOW
if $('body').data('page') is 'CheckinsNew'
  #gets location from browser
  getLocation = ()->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition assignPositionToForm
    else
      x.innerHTML = 'Geolocation is not supported by this browser.'

  #assigns location to hidden form fields
  assignPositionToForm = (position)->
    Ehxe.setFormLatLng position.coords.latitude, position.coords.longitude

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
      icon: Ehxe.markers.black

    #creates check-in info-window
    infowindow = new google.maps.InfoWindow
      content: 'mark your life here'

    google.maps.event.addListener marker, 'dragend', ()->
      position = marker.getPosition()
      Ehxe.setFormLatLng position.lat(), position.lng()

    google.maps.event.addListener marker, 'click', ()->
      infowindow.open map, marker

  google.maps.event.addDomListener window, 'load', getLocation

