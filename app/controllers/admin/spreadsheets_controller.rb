class Admin::SpreadsheetsController < ApplicationController
  before_filter :require_administrator

  def show
    if params[:id] == 'participants'
      @participants = Participant.all
      render 'participants_spreadsheet'

    elsif params[:id] == 'seminars'
      @display_tag = Setting.find_by_key('admin-list-tag').value
      @seminars = Seminar.all
      render 'seminars_spreadsheet'

    else
      flash[:error] = 'Spreadsheet not found'
      redirect_to root_url

    end
  end

end
