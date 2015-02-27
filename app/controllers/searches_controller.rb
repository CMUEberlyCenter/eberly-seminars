class SearchesController < ApplicationController
  include SearchesHelper
  
  def show
    respond_to do |format|
      format.html { redirect_to participant_url(:id => params[:search]) }
      format.json do
        render :json => format_autocomplete_results(
                 search_results: do_search( keyword: params[:term] ) )
      end

    end
  end

  private

  def do_search( options={} )
    CarnegieMellonPerson.autocomplete_results( keyword: options[:keyword] )
    
  end

end
