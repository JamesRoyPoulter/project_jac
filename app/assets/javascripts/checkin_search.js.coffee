# $ ()->
#   $( "#searchQuery" ).autocomplete
#     source: (request, response)->
#       category = $('#searchCategory').val()
#       $.ajax
#         url:
#           if category is 'people'
#             "/search/people"
#           else if category is 'location'
#             "http://ws.geonames.org/searchJSON"
#         dataType:
#           if category is 'people'
#             "json"
#           else if category is 'location'
#             'jsonp'
#         data:
#           featureClass: "P"
#           style: "full"
#           maxRows: 12
#           name_startsWith: request.term
#         success: (data)->
#           if category is 'people'
#             response(
#               $.map data.people, (person)->
#                 return label: person.name, value: person.name
#             )
#           else if category is 'location'
#             response(
#               $.map data.geonames, (item)->
#                 return label: (item.name + ", " + item.countryName), value: item.name
#             )
#     select: (event,ui)->
#       category = $('#searchCategory').val()
#       if category is 'people'
#         $.getJSON '/search/people?name_startsWith='+ui.item.label, (data)->
#           if data.people[0].checkins.length isnt 0
#             $('#itemContainer').html ''
#             index = 1
#             clearMarkers markersArray
#             markersArray.length = 0
#             $.each data.people[0].checkins, (index, checkin)->
#               addCheckinMarker checkin, map, bounds
#               populateTimeLine checkin, index
#               index += 1
#             map.setCenter markersArray[0].position
#             map.setZoom 10
#             paginate()
#           else
#             alert 'You have no checkins with this person'
#       else if category is 'location'
#         $.getJSON '/search/location?name_startsWith='+ui.item.label, (data)->
#           if data.checkins.length isnt 0
#             $('#itemContainer').html ''
#             index = 1
#             clearMarkers markersArray
#             markersArray.length = 0
#             $.each data.checkins, (index, checkin)->
#               addCheckinMarker checkin, map, bounds
#               populateTimeLine checkin, index
#               index += 1
#             map.setCenter markersArray[0].position
#             map.setZoom 10
#             paginate()
#           else
#             alert 'You have no checkins near this location'



