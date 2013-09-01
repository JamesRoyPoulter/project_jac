backgroundColors = Ehxe.marker_hex_values

backgroundHexes = []

for i of backgroundColors
  backgroundHexes.push backgroundColors[i]  if backgroundColors.hasOwnProperty(i)

if $.inArray('#000000', backgroundHexes) != -1
  index = $.inArray('#000000', backgroundHexes)
  delete backgroundHexes[index]

changeBackground = () ->
   $('#logo_marker_background').css 'backgroundColor', (backgroundHexes[Math.floor(Math.random() * backgroundHexes.length)])

setInterval (->
  changeBackground()
), 3000

# if $('body').data('page') is 'Home'
