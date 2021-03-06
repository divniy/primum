# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ->

  source = new EventSource('/event_listener')

  source.addEventListener 'new_post', (e) ->
    data = $.parseJSON(e.data)
    main_headline.new_post(data.post)

  source.addEventListener 'delete_post', (e) ->
    main_headline.delete_post(e.data)

  source.onopen = (e) ->
    console.log "Start live streaming"
  source.onerror = (e) =>
    console.log "EventSource failed. readyState = #{source.readyState}"
