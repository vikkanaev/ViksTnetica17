class SearchesController < ApplicationController
  authorize_resource

  def show
    respond_with(@search_results = Search.search_result(params[:search_string], params[:search_area]))
  end

  private

  def search_params
    params.require(:search_string)
  end
end
