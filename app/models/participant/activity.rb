class Participant::Activity < ActiveRecord::Base
  belongs_to :participant
  belongs_to :status, class_name: "Participant::Activity::Status"
  belongs_to :future_faculty_requirement, class_name: Programs::FutureFaculty::Requirement

  # All activities meeting a requirement for some provided program (e.g.: future_faculty)
  scope :program_requirements, -> (program) { where.not("#{program}_requirement_id".to_sym => nil) }


  # Scopes for each activity type
  #Programs::FutureFaculty::Requirement.find_each do |a|
  #  scope a.key.pluralize, -> { where( type: a.activity_class) }
  #end
  
  # Additional activities are not governed by one specific progam, thus they are explicitly scoped here
  scope :additional, -> { where( type: "Participants::Activities::Additional" ) }


  
  validates :participant, presence: true
  validates_associated :participant
  
  validates_associated :future_faculty_requirement
  
end
