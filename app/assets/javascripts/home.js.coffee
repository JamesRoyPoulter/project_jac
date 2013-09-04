backgroundColors = Ehxe.marker_hex_values

backgroundHexes = []

for i of backgroundColors
  backgroundHexes.push backgroundColors[i] if backgroundColors.hasOwnProperty(i)

if $.inArray('#000000', backgroundHexes) != -1
  index = $.inArray('#000000', backgroundHexes)
  delete backgroundHexes[index]

changeColor = (elements) ->
  for element in elements
    element.css 'backgroundColor', (backgroundHexes[Math.floor(Math.random() * backgroundHexes.length)])

setInterval (->
  changeColor [$('#logo_marker_background'), $('.actions.login'), $('.new_category_button'), $('.new_person_button'), $('.submit_checkin'), $('.actions.category'), $('.actions.person')]
), 3000