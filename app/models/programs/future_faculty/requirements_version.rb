class Programs::FutureFaculty::RequirementsVersion < ActiveRecord::Base
  has_many :requirements, class_name: Programs::FutureFaculty::Requirement, foreign_key: :future_faculty_requirements_version_id
  has_many :categories, -> { uniq }, through: :requirements, source: :requirement_category

  has_many :participants, foreign_key: :future_faculty_enrollment_id
  has_many :pending_graduates, -> { ffp_participants('complete') }, class_name: Participant, foreign_key: :future_faculty_enrollment_id
end
