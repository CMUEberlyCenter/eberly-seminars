class Admin::SeminarsController < ApplicationController
  before_action :require_administrator

  layout 'admin'

  def index
    display_tag = Setting.find_by_key('admin-list-tag').value
    @expired_seminars = Seminar.expired.published.with_tag( display_tag )
    @offered_seminars = Seminar.active.published.with_tag( display_tag )
    @development_seminars = Seminar.development
  end

  def new
    @seminar = Seminar.new
    @seminar.start_at = '12:00:00'
    @seminar.end_at = '14:00:00'
    @seminar.status = SeminarStatus.find_by_key('development')
    # TODO:
    #@seminar.tags = Setting.find_by_key( "default-tag" ).value
    @default_tag = Setting.find_by_key( "default-tag" ).value

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @seminar = Seminar.find(params[:id])
  end


  def create
    @seminar = Seminar.new seminar_params
    @seminar.tags = "#{params[:seminar][:tags]}"
    d = DateTime.strptime("#{params[:seminar][:start_date]}", '%m/%d/%Y')
    tz = Time.local(d.year, d.month, d.day).zone

    @seminar.start_at = DateTime.strptime(
      "#{params[:seminar][:start_date]}" + ' ' + "#{params[:seminar][:start_time]} " + tz, '%m/%d/%Y %l:%M %P %Z'
    )
    @seminar.end_at = DateTime.strptime(
      "#{params[:seminar][:end_date]}" + ' ' + "#{params[:seminar][:end_time]} " + tz, '%m/%d/%Y %l:%M %P %Z'
    )

    #tags = SeminarTag.where('seminar_id is null')
    #tags.each do |t|
    #  t.seminar= @seminar
    #  t.save!
    #end

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
  end


  def show
    @seminar = Seminar.find(params[:id])
    attended = AttendanceStatus.find_by_key("attended")
    inc = AttendanceStatus.find_by_key("attended-incomplete")
    un = AttendanceStatus.find_by_key("absent-unexcused")
    ex = AttendanceStatus.find_by_key("absent-excused")

    @status_icons = { attended => "fa-check-circle",
                     ex => "fa-adjust",
                     un => "fa-times-circle"#,
                     #nil => "fa-ban"
                    }
                     #un => "fa-ban" }
    
    respond_to do |format|
      format.html
      format.pdf { render params[:profile] }
    end
  end

  def mark_attended
    logger.info params
    @registration = Registration.find(params[:id])

    status = params["data_status"]
    if (status == "attended")
      #status = "attended-incomplete" 
    #elsif(status == "attended-incomplete")
      status = "absent-excused"
    elsif(status == "absent-excused")
      status = "absent-unexcused"
    elsif(status == "absent-unexcused")
      status = nil
    elsif(status == "")
      status = "attended"
    end
    logger.info status
    
    @attendance_status = AttendanceStatus.find_by_key(status)
    @registration.attendance_status = @attendance_status
    @registration.save
    redirect_to admin_seminar_path(@registration.seminar)
  end

  
  def mark_all_attended
    #logger.info params
    @seminar = Seminar.find(params[:id])
    status = AttendanceStatus.find_by_key("attended")
    @seminar.registrations.confirmed.each do |r|
      r.attendance_status = status
      r.save
    end
    redirect_to admin_seminar_path(@seminar)
  end
  
  def mark_all_cleared
    @seminar = Seminar.find(params[:id])
    @seminar.registrations.confirmed.each do |r|
      r.attendance_status = nil
      r.save
    end
    redirect_to admin_seminar_path(@seminar)
  end
  
    def update
      logger.info params
      @seminar = Seminar.find(params[:id])
    
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
        wtl.registration_status= RegistrationStatus.find_by_key('pending')
        wtl.save
      end 
      @registered.each do |r| 
        reg = Registration.find(r)
        confirmed = RegistrationStatus.find_by_key('confirmed')
        if reg and reg.registration_status != confirmed
        reg.build_registration_status
          reg.registration_status = confirmed
          if reg.save and reg.seminar.start_at > Time.now
            ParticipantMailer.registration_confirmed_email( reg.participant, reg ).deliver
          end
        end
       end 

       end #if attendance
  end

  def update_seminar
    @seminar = Seminar.find(params[:seminar][:id])
    @seminar.assign_attributes( seminar_params )

    d = DateTime.strptime("#{params[:seminar][:start_date]}", '%m/%d/%Y')
    tz = Time.local(d.year, d.month, d.day).zone
    @seminar.start_at = DateTime.strptime(
      "#{params[:seminar][:start_date]}" + ' ' + "#{params[:seminar][:start_time]} " + tz, '%m/%d/%Y %l:%M %P %Z'
    ).to_time
    @seminar.end_at = DateTime.strptime(
      "#{params[:seminar][:end_date]}" + ' ' + "#{params[:seminar][:end_time]} " + tz, '%m/%d/%Y %l:%M %P %Z'
    ).to_time
    @seminar.save!

    redirect_to admin_seminars_url
  end

  def destroy
    seminar = Seminar.find(params[:id])
    seminar.destroy
    flash[:success] = "Seminar destroyed"
    redirect_to admin_seminars_url
  end


  private
  def seminar_params
    if current_user.is_admin?
      params.require(:seminar).permit(:id, :tags, :title, :description, :start_at, :end_at, :seminar_status_id, :maximum_capacity, :location )
    end
  end
end
