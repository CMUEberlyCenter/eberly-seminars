class Participant::Activity < ActiveRecord::Base
  belongs_to :participant
  belongs_to :status, class_name: 'Participant::Activity::Status', optional: true
  belongs_to :future_faculty_requirement, class_name: 'Programs::FutureFaculty::Requirement', optional: true
  belongs_to :observer, class_name: 'Participant', optional: true
  belongs_to :lead_consultant, class_name: 'Participant', optional: true
  
  # All activities meeting a requirement for some provided program (e.g.: future_faculty)
  scope :program_requirements, -> (program) { where.not("#{program}_requirement_id".to_sym => nil) }


  # Scopes for each activity type
  #Programs::FutureFaculty::Requirement.find_each do |a|
  #  scope a.key.pluralize, -> { where( type: a.activity_class) }
  #end
  
  # Additional activities are not governed by one specific progam, thus they are explicitly scoped here
  scope :additional, -> { where( type: 'Participant::Activities::Additional' ) }


  
  validates :participant, presence: true
  validates_associated :participant
  
  validates_associated :future_faculty_requirement
  
end
