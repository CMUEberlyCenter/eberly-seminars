class SearchController < ApplicationController
  def show
    redirect_to participant_url(:id => params[:tags])
  end
end
