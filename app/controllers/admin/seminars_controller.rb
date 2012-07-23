class Admin::SeminarsController < ApplicationController
  before_filter :require_administrator

  layout 'admin'

  def index
    @seminars = Seminar.active.published
  end

  def new
    @seminar = Seminar.new
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

    @seminar.save;
  end


  def show
    @seminar = Seminar.find(params[:id])
  end

  def update
      logger.error "Starting grabbing the params"
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
        reg.save
       end 
  end

  def update_seminar
    @seminar = Seminar.find(params[:seminar][:id])
    @seminar.attributes = params[:seminar]
    @seminar.save!
    redirect_to admin_seminars_url
  end

end
