wordsAddNumber = 0
categoryAddNumber = 0
peopleAddNumber = 0
mediaAddNumber = 0

page = $('body').data('page')
if page is 'CheckinsNew' || page is 'CheckinsPast' || page is 'CheckinsEdit'

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
    $('#checkin_description').show()

  $('.add_media_overlay').click () ->
    $(@).hide()
    $('.add_media').show()
    addMedia()

  $('#add_categories').click () ->
    addCategory()

  $('#add_people').click () ->
    addPeople()

  $(".remove").click () ->
    # $('#remove_words').trigger('click')
    $('.words_overlay').show()

  $('#add_media').click ()->
    addMedia()

  $('#checkin_description').click () ->
    $(@).css 'text-align', 'left'

  addCategory = () ->
    categoryAddNumber += 1
    if categoryAddNumber>=10
      $('#add_categories').hide()

  addPeople = () ->
    peopleAddNumber += 1
    if peopleAddNumber>=10
      $('#add_people').hide()

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

    $('.checkin_medias').change ()->
      Ehxe.previewImage(".upload_preview", this)

    $('.x_icon').click ()->
      $(@).parent('.new_media').remove()

    mediaAddNumber += 1
    if mediaAddNumber>=5
      $('#add_media').hide()

  autoOpenCategoryChoice = () ->
    $('#auto_open_id').trigger('click')

  autoOpenPeopleChoice = () ->
    $('#auto_open_people_id').trigger('click')

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

    styledMapType = new google.maps.StyledMapType STYLES, name: 'Styled'

    map = Ehxe.Maps.map 'map', Ehxe.Maps.mapOptions myLatlng, 16
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

