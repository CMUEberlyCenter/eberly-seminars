# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AttendanceStatus.destroy_all
RegistrationStatus.destroy_all

['attended','tardy','no show'].each { |status| AttendanceStatus.create(:attendance_status => status) }
['pending','registered','cancelled'].each { |status| RegistrationStatus.create(:registration_status => status) }


SeminarStatus.destroy_all
['development','locked','published'].each { |status| SeminarStatus.create(:seminar_status => status) }

Participant.destroy_all
['meribyte','mg2e','jmbrooks','sa0n','hilaryf','lovett'].each { |andrewid| Participant.create(:andrewid => andrewid, :is_admin => 1) }

#User.create(:login => 'admin', :role => Role.find_by_name('admin'))

Seminar.destroy_all
Seminar.create(:title => "Incorporating Writing in Your Discipline",
               :description => "Writing can facilitate students' learning in any discipline. Consider rationale for writing across the curriculum, discuss low-stakes writing assignments appropriate for a range of courses, and analyze assignments from various disciplines. \(If possible, attend \"Responding to Student Writing\" as well.\)",
               :location => "CYH A72",
               :start => "2012-04-04 07:04:54",
               :end => "2012-04-04 08:04:54",
               :seminar_status_id => 1,
               :maximum_capacity => 25)
