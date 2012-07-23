class SessionController < ApplicationController

  def login
    session[:participant_id] = nil
    respond_to do |format|
      format.js
    end

      principal = params[:id]
      if Participant.find_by_andrewid( principal ) != nil
        session[:participant_id] ||= Participant.find_by_andrewid( principal ).id
      else
        session[:participant_id] = nil
        
      end

      

    if session[:participant_id] != nil and params[:return_url]
      redirect_to params[:return_url]
    elsif params[:id] == 'mg2e'
      redirect_to admin_seminars_url
    elsif session[:participant_id] != nil
      redirect_to seminars_url
    else
      redirect_to root_url
      #redirect_to root_url, :notice => "Logged in"
    end

  end
      

  def logout
    @_current_user = nil
    session[:participant_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end

end
