class BrowserController < ApplicationController
  include ActionController::Live

  def event_listener
    response.headers['Content-Type'] = 'text/event-stream'

    PostFeed.changed do |event, data|
      response.stream.write(sse(data, event: event))
    end

  rescue IOError
    #Client disconnected
  ensure
    response.stream.close
  end

  private

  def sse(data, options = {})
    (options.map{|k,v| "#{k}: #{v}" } << "data: #{data}").join("\n") + "\n\n"
  end
end
