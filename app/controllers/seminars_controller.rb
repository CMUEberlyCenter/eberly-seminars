class SeminarsController < ApplicationController
  skip_before_filter :require_authentication, only: :index

  private def check_install
    print ("Checking installation ...\n")

    # Listing of all tables and views
    ActiveRecord::Base.connection.tables

    # Checks for existence of seminars table/view
    return (ActiveRecord::Base.connection.table_exists? 'seminars')
  end

  def index
    if (check_install == false)
      render html: "This appears to be a new installation, please make sure you have configured the datbase properly. Run 'rake db:migrate' or 'rake:load' first."
    else
      if administrator?
        flash.keep
        redirect_to admin_seminars_url
       else
        #flash[:notice] = "Announcement text"
        @seminars = Seminar.active.published
        if !@seminars
          render html: "This appears to be a new installation, please make sure you have basic data in your database. Run 'rake db:seed' first."
        end  
      end
    end   
  end

end
