# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery(document).ready ->
  source = new EventSource('/event_listener')
  source.addEventListener 'test_event', (e) ->
    data = $.parseJSON(e.data)
    create_post(data)