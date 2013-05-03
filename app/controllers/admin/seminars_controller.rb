class Admin::SeminarsController < ApplicationController
  before_filter :require_administrator

  layout 'admin'

  def index
    display_tag = Setting.find_by_key('admin-list-tag').value
    @expired_seminars = Seminar.expired.published.delete_if{ |x| !x.tags.include? display_tag }
    @offered_seminars = Seminar.active.published.delete_if{ |x| !x.tags.include? display_tag }
    @development_seminars = Seminar.development
  end

  def new
    @seminar = Seminar.new
    @seminar.start_at = '12:00:00'
    @seminar.end_at = '14:00:00'
    @seminar.status = SeminarStatus.find_by_status('development')
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
    @seminar = Seminar.new(params[:seminar])
    d = DateTime.strptime("#{params[:seminar][:start_date]}", '%m/%d/%Y')
    tz = Time.local(d.year, d.month, d.day).zone

    @seminar.start_at = DateTime.strptime(
      "#{params[:seminar][:start_date]}" + ' ' + "#{params[:seminar][:start_time]} " + tz, '%m/%d/%Y %l:%M %P %Z'
    )
    @seminar.end_at = DateTime.strptime(
      "#{params[:seminar][:end_date]}" + ' ' + "#{params[:seminar][:end_time]} " + tz, '%m/%d/%Y %l:%M %P %Z'
    )

    tags = SeminarTag.where('seminar_id is null')
    tags.each do |t|
      t.seminar= @seminar
      t.save!
    end

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
    respond_to do |format|
      format.html
      format.pdf { render params[:profile] }
    end
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
        wtl.registration_status= RegistrationStatus.find_by_status('pending')
        wtl.save
      end 
      @registered.each do |r| 
        reg = Registration.find(r)
        confirmed = RegistrationStatus.find_by_status('confirmed')
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
    @seminar.attributes = params[:seminar]

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

end
