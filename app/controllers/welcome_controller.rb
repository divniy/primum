class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    find_posts
    find_filters
    @post = Post.new
    #stop_manage_filters
  end
end
