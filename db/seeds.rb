# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Populate each seminar status if it doesn't already exist
['development','locked','published'].each { |status| SeminarStatus.find_or_create_by( :key => status) }

# Populate each registration status if it doesn't already exist
#
# TODO: Yeah... I spelled canceled wrong.
['pending','confirmed','cancelled','cancelled_late'].
  each { |status| RegistrationStatus.find_or_create_by( :key => status ) }

# Populate each attendance status if it doesn't already exist
#
# TODO: Ruby 1.9.1 really doesn't like '-' in symbol names. Deal with renaming these
# before they get used in a scope or something similar.
['attended','attended-incomplete','absent-unexcused','absent-excused'].
  each { |status| AttendanceStatus.find_or_create_by( :key => status ) }

# Create certain admins by default if they don't already exist
['meribyte','jmbrooks','rpoprosk','hershock','hdwyer'].each do |andrewid|
  Participant.find_or_create_by( { :andrewid => andrewid } ) do |u|
    u.is_admin = true
  end
end

# Create default application-wide settings if they don't already exist
#
# TODO: Ruby 1.9.1 really doesn't like '-' in symbol names. Deal with renaming these
# before they get used in a scope or something similar.
Setting.find_or_create_by( :key => "default-tag" ) do |s|
  s.label = "Default tag for new seminars"
  s.value = "S13"
end

Setting.find_or_create_by( :key => "admin-list-tag" ) do |s|
  s.label = "List seminars in admin view with tag"
  s.value = "S13"
end


##
# Future Faculty Program additions

# TODO: Make this less clunky after phasing out protected_attr gem.

# Requirements Versions
v1 = Programs::FutureFaculty::RequirementsVersion.find_or_create_by(
  key: '2012') do |v|
  v.key = '2012'
  v.label = 'Requirements in place on app launch (2012)'
end

v2 = Programs::FutureFaculty::RequirementsVersion.find_or_create_by(
  key: '2015') do |v|
  v.key = '2015'
  v.label = 'Requirements in effect 1/1/2015.'
end

# Requirement Categories and Requirements
c = Programs::FutureFaculty::RequirementCategory.find_or_create_by(
  key: 'projects') do |p|
  p.key = 'projects'
  p.label = 'Projects'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'course_project',
  requirements_version: v1,
  requirement_category: c ) do |p|
  p.key = 'course_project'
  p.label = 'Course & Syllabus Design Project'
  p.requirements_version = v1
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::CourseAndSyllabusDesignProject'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'individual_project',
  requirements_version: v1,
  requirement_category: c ) do |p|
  p.label = 'Individual Project'
  p.key = 'individual_project'
  p.requirements_version = v1
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::IndividualProject'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'course_project',
  requirements_version: v2,
  requirement_category: c ) do |p|
  p.label = 'Course & Syllabus Design Project'
  p.key = 'course_project'
  p.requirements_version = v2
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::CourseAndSyllabusDesignProject'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'statement_project',
  requirements_version: v2,
  requirement_category: c ) do |p|
  p.label = 'Teaching Statement Project'
  p.key = 'statement_project'
  p.requirements_version = v2
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::TeachingStatementProject'
end

c = Programs::FutureFaculty::RequirementCategory.find_or_create_by(
  key: 'observations') do |p|
  p.label = 'Observations'
  p.key = 'observations'
end


Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'microteaching_observation',
  requirements_version: v1,
  requirement_category: c ) do |p|
  p.label = 'Microteaching Observation'
  p.key = 'microteaching_observation'
  p.requirements_version = v1
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::MicroteachingObservation'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'classroom_observation',
  requirements_version: v1,
  requirement_category: c ) do |p|
  p.label = 'Classroom Observation'
  p.key = 'classroom_observation'
  p.requirements_version = v1
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::ClassroomObservation'
end


c = Programs::FutureFaculty::RequirementCategory.find_or_create_by(
  key: 'teaching_consultations') do |p|
  p.label = 'Teaching Feedback Consultations'
  p.key = 'teaching_consultations'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'microteaching_workshop',
  requirements_version: v2,
  requirement_category: c ) do |p|
  p.label = 'Microteaching Workshop and Follow-Up Conversation'
  p.key = 'microteaching_workshop'
  p.requirements_version = v2
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::MicroteachingWorkshop'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'teaching_observation',
  requirements_version: v2,
  requirement_category: c ) do |p|
  p.label = 'Teaching Observation'
  p.key = 'teaching_observation'
  p.requirements_version = v2
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::TeachingObservation'
end

Programs::FutureFaculty::Requirement.find_or_create_by(
  key: 'ecf_fg_observation',
  requirements_version: v2,
  requirement_category: c ) do |p|
  p.label = 'Early Course Feedback/Focus Group'
  p.key = 'ecf_fg_observation'
  p.requirements_version = v2
  p.requirement_category = c
  p.activity_class = 'Participants::Activities::EarlyCourseFeedback'
end

