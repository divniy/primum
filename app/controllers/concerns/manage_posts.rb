module ManagePosts
  extend ActiveSupport::Concern

  included do
    helper_method :manage_posts_key
    helper PostsHelper
  end

  def manage_posts_key
    'manage_posts'
  end

  def stop_manage_posts
    user_session[manage_posts_key] = false
  end

  module PostsHelper
    def manage_filters?
      user_signed_in? && user_session[manage_posts_key] == true
    end

    def manage_posts_toggle
      button_classes = %w(btn btn-info btn-small btn-block)
      toggle_link_to 'Manage Posts', posts_path, manage_posts_key, class: button_classes
    end
  end
end