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
# TODO: Yeah... I spelled canceled wrong.
['pending','confirmed','cancelled','cancelled_late'].
  each { |status| RegistrationStatus.find_or_create_by_key( :key => status ) }

# Populate each attendance status if it doesn't already exist
#
# TODO: Ruby 1.9.1 really doesn't like '-' in symbol names. Deal with renaming these
# before they get used in a scope or something similar.
['attended','attended-incomplete','absent-unexcused','absent-excused'].
  each { |status| AttendanceStatus.find_or_create_by_key( :key => status ) }

# Create certain admins by default if they don't already exist
['meribyte','jmbrooks','rpoprosk','hershock','hdwyer'].
  each { |andrewid| Participant.find_or_create_by_andrewid( { :andrewid => andrewid, :is_admin => true },
                                                            :without_protection => true) }

# Create default application-wide settings if they don't already exist
#
# TODO: Ruby 1.9.1 really doesn't like '-' in symbol names. Deal with renaming these
# before they get used in a scope or something similar.
Setting.find_or_create_by_key(
                              :key => "default-tag", 
                              :label => "Default tag for new seminars", 
                              :value => "S13" )

Setting.find_or_create_by_key( 
                              :key => "admin-list-tag", 
                              :label => "List seminars in admin view with tag", 
                              :value => "S13" )

##
# Future Faculty Program additions

# Create each observation type if it doesn't already exist
ObservationType.find_or_create_by_key(
                                      :key => 'microteaching',
                                      :label => 'Microteaching Observation' )
ObservationType.find_or_create_by_key(
                                      :key => 'classroom_observation',
                                      :label => 'Classroom Observation' )
ObservationType.find_or_create_by_key(
                                      :key => 'early_course_feedback',
                                      :label => 'Early Course Feedback/Focus Group' )

# Create each project type if it doesn't already exist
ProjectType.find_or_create_by_key(
                                  :key => 'course',
                                  :label => 'Course & Syllabus Design Project' )

ProjectType.find_or_create_by_key(
                                  :key => 'individual',
                                  :label => 'Individual Project' )

# Create each project status if it doesn't already exist
ProjectStatus.find_or_create_by_key(
                                    :key => 'not_started',
                                    :label => 'Not Started' )

ProjectStatus.find_or_create_by_key(
                                    :key => 'approved',
                                    :label => 'Approved' )

ProjectStatus.find_or_create_by_key(
                                    :key => 'completed',
                                    :label => 'Completed' )
