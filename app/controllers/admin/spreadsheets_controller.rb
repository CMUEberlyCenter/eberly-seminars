class Admin::SpreadsheetsController < ApplicationController
  before_filter :require_administrator

  def show
    @participants = Participant.all
  end

end
