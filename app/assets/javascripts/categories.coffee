if $('body').data('page') is 'CategoriesEdit' or 'CategoriesNew'

  $('#marker').attr 'src', markerColor($('#category_color :selected').val())

  $('#category_color').change ()->
    color = $('#category_color :selected').val()
    $('#marker').attr 'src', markerColor(color)
