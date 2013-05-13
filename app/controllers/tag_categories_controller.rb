class TagCategoriesController < ApplicationController

  before_action :toggle_tag_management_mode, :only => :index

  def index
    @tag_categories = TagCategory.all
    @tag_category = TagCategory.new
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def toggle_tag_management_mode
    if user_signed_in? && params[:toggle_managing_tags]
      user_session[:managing_tags] = !user_session[:managing_tags]
    end
  end
end
