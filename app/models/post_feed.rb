class PostFeed
  class << self
    EVENTS = ['new_post', 'delete_post']

    def create(post)
      post_json = PostSerializer.new(post).to_json
      notify_about 'new_post', post_json
    end

    def delete(post)
      notify_about 'delete_post', post.id.to_s
    end

    def changed
      connection = ActiveRecord::Base.connection_pool.checkout
      EVENTS.each do |event|
        connection.execute "LISTEN #{event}"
      end
      loop do
        connection.raw_connection.wait_for_notify do |event, pid, data|
          yield event, data
        end
      end
    end

    private

    def notify_about(event, data)
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        connection.execute "NOTIFY #{event}, #{connection.quote(data)}"
      end
    end
  end
end