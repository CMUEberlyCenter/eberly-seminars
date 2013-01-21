class Admin::RegistrationsController < ApplicationController
  before_filter :require_administrator

  def new
    @registration = Registration.new(params[:registration])
    @registration.registration_status = RegistrationStatus.find_by_status('confirmed')
    @registration.attendance_status = AttendanceStatus.find_by_status('attended')
  end

  def create  
    @registration = Registration.new(params[:registration] )
    @registration.seminar_id = params[:seminar_id]
    @registration.attendance_status = AttendanceStatus.find_by_status('attended')
    
    respond_to do |format|
      if @registration.save
        if @registration.seminar.start_at > Time.now
          ParticipantMailer.registration_confirmed_email( @registration.participant, @registration ).deliver
        end
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
