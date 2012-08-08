# 0 12 * * * /bin/bash -l -c 'cd /opt/rails/graduate-students && RAILS_ENV=production rake cron:nightly_chores --silent'

namespace :cron do

  task :nightly_chores => [:environment, :send_reminders]


  task :send_reminders => [:send_one_week_reminder]

  task :send_one_week_reminder do
    
    Seminar.days_away( 7 ).published.each do |seminar|
      seminar.registrations.each do |registration|
        ParticipantMailer.seminar_one_week_reminder_email( registration ).deliver
      end
    end

  end

end
