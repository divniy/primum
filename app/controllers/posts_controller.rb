require 'ffaker'

class PostsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_new_post, only: [:index]
  before_action :set_post, only: [:destroy]

  before_action :set_session_tags, only: [:index]
  before_action :set_available_tags, only: [:index]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.by_creation
    if user_session[:tags].present?
      @posts = @posts.tagged_with(user_session[:tags])
    end

    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.js
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        @post.reload.notify_post_create
        @post_json = PostSerializer.new(@post).to_json if Rails.env == 'development'

        set_available_tags
        set_new_post

        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.js { render nothing: true if Rails.env == 'production' }
      else
        format.html { render action: 'index' }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.js
    end
  end

  private
    def set_new_post
      @post = Post.new(
          body: Faker::Lorem.paragraph(1)
      )
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def set_available_tags
      @tags = ActsAsTaggableOn::Tag.all
    end

    def set_session_tags
      user_session[:tags] ||= ['all']
      if params.include? :tags
        params[:tags].delete 'all'
        user_session[:tags] = params[:tags].present? ? params[:tags] : []
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body, {tag_ids: []}, {tag_list: []})
    end
end
