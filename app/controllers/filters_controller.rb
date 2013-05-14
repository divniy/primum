class FiltersController < ApplicationController

  before_action :set_filter_mode, only: :index

  def index
    find_filters
    @filter = Filter.new
  end

  def create
    @filter = Filter.new(filter_params)
    @filter.save
  end

  def destroy
    @filter = Filter.find(params[:id]).destroy
  end

  private

  def set_filter_mode
    if params.include?(:session_key) && params[:session_key] == manage_filters_key
      user_session[manage_filters_key] = true  if params[:session_value] == 'false'
      user_session[manage_filters_key] = false if params[:session_value] == 'true'
    end
  end

  def filter_params
    params.require(:filter).permit(:title)
  end
end
