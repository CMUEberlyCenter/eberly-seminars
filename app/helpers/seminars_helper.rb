module SeminarsHelper

  def seminar_groups( seminars )
    groups = Array.new
    if authenticated?
      groups << confirmed( seminars )
      groups << pending( seminars )
      groups << unrequested( seminars )
    else
      groups << upcoming( seminars )
    end

    # only display seminar groups that have seminars in them
    groups.delete_if{ |g| g.seminars.size <= 0 }

    render groups
  end

  def seminar_registration_options( seminar )
    if authenticated?
      registration = seminar.registration_for( current_user )
      if registration && registration.confirmed?
        link_to 'Cancel Registration',
          seminar_registration_path( 
            :seminar_id => seminar.id,
            :id => registration.id 
          ), 
          :method => :delete,
          :class => 'seminar-registration-cancel boxy',
          :remote => true

      elsif registration && registration.pending?
        link_to 'Cancel Request', 
          seminar_registration_path( 
            :seminar_id => seminar.id,
            :id => registration.id 
          ), 
          :method => :delete,
          :class => 'seminar-request-cancel boxy',
          :remote => true

      else
        link_to 'Request Registration',
          seminar_registrations_path(
            :seminar_id => seminar.id
          ),
          :method => :post,
          :class => 'seminar-request boxy',
          :remote => true

      end
      
    end
  end


  private

  def confirmed( seminars )
    SeminarGroup.new(
      :title => 'Seminars you are attending &ndash; <em>Confirmed</em>',
      :css_class => 'confirmed',
      :seminars => seminars.confirmed_for( current_user )
    )
  end

  def pending( seminars )
    SeminarGroup.new(
      :title => 'Seminars you have requested &ndash; <em>Pending</em>',
      :css_class => 'pending',
      :seminars => seminars.pending_for( current_user )
    )
  end

  def unrequested( seminars )
    SeminarGroup.new(
      :title => 'Other seminars we are currently offering',
      :css_class => 'offering',
      :seminars => seminars.unrequested_by( current_user )
    )
  end

  def upcoming( seminars )
    SeminarGroup.new(
      :title => 'Upcoming ' + current_semester + ' Teaching Seminars', 
      :css_class => 'offering',
      :seminars => seminars.upcoming
    )
  end

end
