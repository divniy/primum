class TagsController < ApplicationController
  def new
    @tag = Filter.find(params[:filter_id])
  end

  def create
    logger.debug params
  end

  private

  def tags_params
    params.require(:filter).permit(:title)
  end
end