# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Populate each seminar status if it doesn't already exist
['development','locked','published'].each { |status| SeminarStatus.find_or_create_by_key( :key => status) }

# Populate each registration status if it doesn't already exist
#
# TODO: Yeah... I spelled canceled wrong. When you go in to fix this, 
#       make canceled-late a hyphen instead of an underscore.
['pending','confirmed','cancelled','cancelled_late'].
  each { |status| RegistrationStatus.find_or_create_by_key( :key => status ) }

# Populate each attendance status if it doesn't already exist
['attended','attended-incomplete','absent-unexcused','absent-excused'].
  each { |status| AttendanceStatus.find_or_create_by_key( :key => status ) }



Participant.destroy_all
['meribyte','mg2e','jmbrooks','sa0n','hilaryf','lovett'].each { |andrewid| Participant.create(:andrewid => andrewid, :is_admin => 1) }
['rpoprosk','adrake','lsudol'].each { |andrewid| Participant.create(:andrewid => andrewid, :is_admin => 0) }

Setting.create( :label => "Default tag for new seminars", :key => "default-tag", :value => "S13" )
Setting.create( :label => "List seminars in admin view with tag", :key => "admin-list-tag", :value => "S13" )

#User.create(:login => 'admin', :role => Role.find_by_name('admin'))

Seminar.destroy_all
Seminar.create(:title => "Incorporating Writing in Your Discipline",
               :description => "Writing can facilitate students' learning in any discipline. Consider rationale for writing across the curriculum, discuss low-stakes writing assignments appropriate for a range of courses, and analyze assignments from various disciplines. \(If possible, attend \"Responding to Student Writing\" as well.\)",
               :location => "CYH A72",
               :start_at => "2012-05-09 07:04:54 EDT",
               :end_at => "2012-05-09 12:04:54 EDT",
               :seminar_status => SeminarStatus.find_by_status('published'),
               :maximum_capacity => 25)

Seminar.create(:title => "Responding to Student Writing ",
               :description => "Writing can facilitate students' learning in any discipline. Consider rationale for writing across the curriculum, discuss low-stakes writing assignments appropriate for a range of courses, and analyze assignments from various disciplines. \(If possible, attend \"Responding to Student Writing\" as well.\)",
               :location => "CYH A72",
               :start_at => "2012-05-08 07:04:54 EDT",
               :end_at => "2012-05-08 12:04:54 EDT",
               :seminar_status => SeminarStatus.find_by_status('published'),
               :maximum_capacity => 25)

Registration.create(:participant => Participant.find_by_andrewid('lsudol'),
                    :seminar => Seminar.find_by_title('Incorporating Writing in Your Discipline'),
                    :registration_status => RegistrationStatus.find_by_status('pending')
                    )

Registration.create(:participant=> Participant.find_by_andrewid('adrake'),
                    :seminar => Seminar.find_by_title('Incorporating Writing in Your Discipline'),:registration_status => RegistrationStatus.find_by_status('pending'))
Registration.create(:participant => Participant.find_by_andrewid('jmbrooks'),
                    :seminar => Seminar.find_by_title('Incorporating Writing in Your Discipline'),:registration_status => RegistrationStatus.find_by_status('pending'))
               
                                                       

