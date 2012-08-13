class Admin::SeminarsController < ApplicationController
  before_filter :require_administrator

  layout 'admin'

  def index
    @offered_seminars = Seminar.active.published
    @development_seminars = Seminar.active.development
  end

  def new
    @seminar = Seminar.new
    @seminar.start_at = '12:00:00'
    @seminar.end_at = '14:00:00'
    @seminar.status = SeminarStatus.find_by_status('development')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @seminar = Seminar.find(params[:id])
  end


  def create
    @seminar = Seminar.new(params[:seminar])
    @seminar.start_at = DateTime.strptime(
      "#{params[:seminar][:start_date]}" + ' ' + "#{params[:seminar][:start_time]}", '%m/%d/%Y %l:%M %P'
    )
    @seminar.end_at = DateTime.strptime(
      "#{params[:seminar][:end_date]}" + ' ' + "#{params[:seminar][:end_time]}", '%m/%d/%Y %l:%M %P'
    )

    respond_to do |format|
      if @seminar.save
        format.html  { redirect_to(admin_seminar_path(@seminar),
                                   :notice => 'Seminar was successfully created.') }
        format.json  { render :json => @seminar,
          :status => :created, :location => @seminar }
      else

        format.html  { render :action => "new" }
        format.json  { render :json => @seminar.errors,
          :status => :unprocessable_entity }
      end
    end

    @seminar.save
  end


  def show
    @seminar = Seminar.find(params[:id])
  end

  def update
      logger.info params
    
      if params[:attendance_status]
        registration = Registration.find(params[:registration_id])
        registration.attendance_status_id = params[:attendance_status]
        registration.save
      else

      @waitlists = CGI.parse(params[:waitlisted])['ids[]'].map{ |x| x.to_i }
      @registered = CGI.parse(params[:registered])['ids[]'].map { |x| x.to_i }
      logger.info "Waitlists: #{@waitlists}"
      logger.info "Registered #{@registered}"
      @waitlists.each do |w| 
        wtl = Registration.find(w)
        wtl.build_registration_status
        wtl.registration_status= RegistrationStatus.find_by_status('pending')
        wtl.save
      end 
      @registered.each do |r| 
        reg = Registration.find(r)
        reg.build_registration_status
        reg.registration_status= RegistrationStatus.find_by_status('confirmed')
        if reg.save
           ParticipantMailer.registration_confirmed_email( reg.participant, reg ).deliver
        end
       end 

       end #if attendance
  end

  def update_seminar
    @seminar = Seminar.find(params[:seminar][:id])
    @seminar.attributes = params[:seminar]
    @seminar.start_at = DateTime.strptime(
      "#{params[:seminar][:start_date]}" + ' ' + "#{params[:seminar][:start_time]}", '%m/%d/%Y %l:%M %P'
    )
    @seminar.end_at = DateTime.strptime(
      "#{params[:seminar][:end_date]}" + ' ' + "#{params[:seminar][:end_time]}", '%m/%d/%Y %l:%M %P'
    )
    @seminar.save!
    redirect_to admin_seminars_url
  end

  def destroy
    seminar = Seminar.find(params[:id])
    seminar.destroy
    flash[:success] = "Seminar destroyed"
    redirect_to admin_seminars_url
  end

end
