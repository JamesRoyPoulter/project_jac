$(function() {
  var assets, width,
    _this = this;
  assets = $('.assets_container .assets');
  if (assets.length > 0) {
    width = 0;
    assets.children().each(function(index, element) {
      return width += $(element).width() + 10;
    });
    return assets.css({
      width: "" + width + "px",
      maxWidth: "" + width + "px"
    });
  }
});
