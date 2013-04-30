class WelcomeController < ApplicationController
  def index
    @posts = Post.by_creation
  end
end
