class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    find_posts
    find_filters

    #@tags = ActsAsTaggableOn::Tag.all
    #stop_manage_filters
  end
end
