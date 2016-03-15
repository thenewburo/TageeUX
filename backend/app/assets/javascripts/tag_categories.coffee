# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('select[data-multiple] option').mousedown (e)->
    e.preventDefault();
    $(this).prop('selected', !$(this).prop('selected'));
    return false;