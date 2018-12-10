# 0 12 * * * /bin/bash -l -c 'cd /opt/rails/graduate-students && RAILS_ENV=production rake cron:nightly_chores --silent'

namespace :cron do

  task :nightly_chores => [:environment, :send_reminders, :recalculate_ffp_progress]


  task :send_reminders => [:send_one_week_reminder, :send_two_day_reminder]

  task :send_one_week_reminder do
    Seminar.days_away( 7 ).published.each do |seminar|
      seminar.registrations.each do |registration|
        ParticipantMailer.generic_reminder_email( registration ).deliver
      end
    end
  end


  task :send_two_day_reminder do
    Seminar.days_away( 2 ).published.each do |seminar|
      seminar.registrations.each do |registration|
        ParticipantMailer.generic_reminder_email( registration ).deliver
      end
    end
  end

  task :recalculate_ffp_progress do
    # TODO: Add "active" boolean to RV and select all active RVs
    v = Programs::FutureFaculty::RequirementsVersion.find_by_key("2015")
    s = Program::ProgressStatusType.find("incomplete")
    v.participants.where(future_faculty_progress_status: s).each do |p|
      p.future_faculty_progress_status = v.calculate_participant_status(p)
      p.save
    end
  end

end
