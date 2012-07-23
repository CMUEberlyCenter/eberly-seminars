class Admin::SpreadsheetsController < ApplicationController

def show

  @participants = Participant.all
end

end
