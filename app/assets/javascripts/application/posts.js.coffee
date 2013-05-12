# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.replace_posts = (data) ->
  $('.headline').html(data)

window.replace_form = (data) ->
  $('.new_post').html(data)

window.create_post = (data) ->
  console.log "Incoming data:"
  console.log data
  post = data.post

  if post.tag_list.length == 0
    draw_post(post)
    return
  #tag_names = post.tags.map (mupped) -> mupped.name
  draw_post(post) if tag_filter.permit_tags(post.tag_list)



window.draw_post = (post) ->
  console.log "Draw data:"
  console.log post.tag_list

  wrapper = $('<div class="well well-small"></div>').attr('id', "post_#{post.id}")

  close_btn = $('<a class="close" rel="nofollow" data-method="delete" data-remote="true" href="#">&times;</a>').attr('href', "/posts/#{post.id}")
  time = $("<p><small>#{post.created_at}</small></p>")

  if post.tag_list.length > 0
    for tag_name in post.tag_list
      $("<span class='tag label'>#{tag_name}</span>").appendTo(time)

  body = $("<p>#{post.body}</p>")

  wrapper.append(close_btn)
  wrapper.append(time)
  wrapper.append(body)

  $('.headline').prepend(wrapper)

window.delete_post = (post_id) ->
  console.log "Delete post with id: #{post_id}"
  $("#post_#{post_id}").remove()