class window.Filter
  constructor: () ->
    @context = $('.tag_filter_form')
    @auto_submit()

  auto_submit: ->
    @context.find('[type=submit]').remove()
    @context.find('input[type=checkbox]').on 'click', =>
      @context.submit()

  tag_list: ->
    tag_names = []
    @context.find("input[type=checkbox]:checked").each ->
      tag_names.push $(@).val()
    tag_names

  permit_tags: (post_tags) ->
    required_tags = @tag_list()
    console.log "Post tags: [#{post_tags}], required tags [#{required_tags}]"

    if required_tags.length == 0
      console.log "Filter off: all tags permited"
      return true

    for req_tag in required_tags
      if req_tag not in post_tags
        console.log "Deny: required tag '#{req_tag}' not in post tags ['#{post_tags}']"
        return false

    console.log "Permit: required tags [#{required_tags}] contains in post tags [#{post_tags}]"
    return true

$(document).bind 'ready page:load', ->
  window.tag_filter = new Filter