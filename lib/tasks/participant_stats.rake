# rake participant_stats:do_stats --silent

namespace :participant_stats do

  task :do_stats => [:environment, :print_service_breakup]

  task :print_service_breakup do
    print "\"Andrew ID\",\"Name\",\"College\",\"Department\",\"Student Class\"," +
     	  "\"Registrations Made\",\"Registrations Confirmed\",\"% Confirmed\"\n"

    semesters=["F11","S12","U12"]
    parts = []
    semesters.each do |s|
      parts+=Seminar.with_tag(s).collect(&:registrations).flatten.map(&:participant)
    end
    #    Participant.all.each do |p|
    parts.uniq.each do |p|
      if p.registrations.size > 0 and not p.is_admin
        r=0
        t=0
        semesters.each { |y|  r += p.registrations.collect(&:seminar).select{|x| x.tags.include?(y)}.size }
        semesters.each { |y|  t += p.registrations.confirmed.collect(&:seminar).select{|x| x.tags.include?(y)}.size }
        print "\"#{p.andrewid}\",\"#{p.name}\",\"#{p.college}\",\"#{p.department}\"," +
	      "\"#{p.student_class}\", \"#{r}\"," +
	      "\"#{t}\"," +
	      "\"#{t.to_f/r}\""+
	      "\n"
      end
    end
  end

end
