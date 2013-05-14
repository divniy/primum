class TagsController < ApplicationController
  def new
    @filter = Filter.find(params[:filter_id])
    @tag = @filter.tags.build
  end

  def create
    @filter = Filter.find(params[:filter_id])
    @tag = @filter.tags.build(tags_params)
    @tag.save
  end

  def destroy
    @tag = Tag.find(params[:id]).destroy
  end

  private

  def tags_params
    params.require(:tag).permit(:name)
  end
end