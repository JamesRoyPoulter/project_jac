if $('body').data('page') is 'CategoriesEdit' or 'CategoriesNew'
  $('#category_color').change ()->
    color = $('#category_color :selected').val()
    console.log color
    $('#marker').attr 'src', markerColor(color)
