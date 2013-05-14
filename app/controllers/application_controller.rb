class ApplicationController < ActionController::Base
  include ManageFilters
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def find_filters
    @filters = Filter.all
  end

  def find_posts
    @posts = Post
    if user_session[:tags].present?
      @posts = @posts.tagged_with(user_session[:tags])
    end
    @posts = @posts.by_creation.decorate
  end

end
