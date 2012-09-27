# rake participant_stats:do_stats --silent

namespace :participant_stats do

  task :do_stats => [:environment, :print_service_breakup]

  task :print_service_breakup do
    print "\"Andrew ID\",\"Name\",\"Department\",\"Student Class\"," +
     	  "\"Registrations Made\",\"Registrations Confirmed\",\"% Confirmed\"\n"

    Participant.all.each do |p|
      if p.registrations.size > 0 and not p.is_admin
        print "\"#{p.andrewid}\",\"#{p.name}\",\"#{p.department}\"," +
	      "\"#{p.student_class}\", \"#{p.registrations.size}\"," +
	      "\"#{p.registrations.confirmed.size}\"," +
	      "\"#{p.registrations.confirmed.size.to_f/p.registrations.size}\""+
	      "\n"
      end
    end
  end

end
