class PostFeed
  class << self
    def create(post)
      #post.reload
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        post_json = PostSerializer.new(post).to_json
        ActiveRecord::Base.logger.debug "post_json: #{post_json}"
        connection.execute "NOTIFY #{channel}, #{connection.quote(post_json)}"
      end
    end

    def on_create
      connection = ActiveRecord::Base.connection_pool.checkout
      connection.execute "LISTEN #{channel}"
      loop do
        connection.raw_connection.wait_for_notify do |event, pid, post_json|
          yield post_json
        end
      end
    ensure
      connection.execute "UNLISTEN #{channel}"
      ActiveRecord::Base.connection_pool.checkin(connection)
    end

    def channel
      "test_channel"
    end
  end
end