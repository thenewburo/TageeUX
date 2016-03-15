$(document).ready(function() {
  $('body').on('click', 'a[data-open="hashtag-modal"]', function() {
    $('#hashtag-modal .content').html($(this).html());
    $('#tag').val($(this).attr('data-tag'));
  });
});
