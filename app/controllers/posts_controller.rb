class PostsController < ApplicationController
  before_action :set_new_post, only: [:index]
  before_action :set_post, only: [:destroy]
  before_action :set_tags, only: [:index]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    if params[:tags].present?
      logger.debug params[:tags]
      @posts = @posts.tagged_with(params[:tags])
    end
    @posts = @posts.by_creation

    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.js
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        @post.reload.notify_post_create
        @post_json = PostSerializer.new(@post).to_json
        set_tags
        set_new_post

        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.js   {

          #render nothing: true
        }
      else
        format.html { render action: 'index' }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
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

    def set_tags
      @tags = ActsAsTaggableOn::Tag.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      #logger << params.inspect
      params.require(:post).permit(:body, {tag_ids: []}, {tag_list: []})
    end
end
