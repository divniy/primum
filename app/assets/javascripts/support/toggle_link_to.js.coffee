jQuery(document).on 'ready', ->
  $("[data-toggle-session]").on 'click', (e) ->
    session_key = $(this).data('toggle-session')
    session_value = if $(this).hasClass('active') then 'true' else 'false'
    session_pare = { session_key: session_key, session_value: session_value }
#    console.log "Toggle:"
#    console.log session_pare

    $(this).data('params', session_pare)

