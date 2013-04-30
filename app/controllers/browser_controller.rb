class BrowserController < ApplicationController
  include ActionController::Live

  def event_listener
    response.headers['Content-Type'] = 'text/event-stream'

    #post = Post.new
    #post.on_post_create do |post|
    #  response.stream.write(sse({post: post}, {event: 'test_event'}))
    #end
    PostFeed.on_create do |post|
      response.stream.write(sse(post, {event: 'test_event'}))
    end
  rescue IOError
    #Client disconnected
  ensure
    response.stream.close
  end

  private

  def sse(object, options = {})
    (options.map{|k,v| "#{k}: #{v}" } << "data: #{object}").join("\n") + "\n\n"
  end
end
