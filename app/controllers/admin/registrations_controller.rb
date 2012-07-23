class Admin::RegistrationsController < ApplicationController

  def new
    @registration = Registration.new(params[:registration])
    @registration.registration_status = RegistrationStatus.find_by_status('confirmed')
  end

  def create  
    @registration = Registration.new(params[:registration] )
    @registration.seminar_id = params[:seminar_id]
    
    respond_to do |format|  
      if @registration.save  
        format.html { redirect_to(admin_seminar_path(@registration.seminar), :notice => 'Registration created.') }
        format.js  
      else
        format.html { render :action => "new" }  
        format.js  
      end  
    end  
    rescue 
    redirect_to(admin_seminar_path(params[:seminar_id]), :notice => 'Invalid AndrewID')
    #render :controller => 'admin/seminars', :action =>"new" ,:notice => 'Invalid AndrewID'
  end 
  
end
