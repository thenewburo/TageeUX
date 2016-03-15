$(document).ready(function() {
  var $tags = $('.tags').masonry({
    // set itemSelector so .grid-sizer is not used in layout
    itemSelector: '.tag'
  });
  $tags.imagesLoaded().progress(function() {
    $tags.masonry('layout');
  });
});
