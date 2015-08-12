class Programs::FutureFaculty::Requirement < ActiveRecord::Base
  belongs_to :requirements_version, class_name: Programs::FutureFaculty::RequirementsVersion, foreign_key: :future_faculty_requirements_version_id
  belongs_to :requirement_category, class_name: Programs::FutureFaculty::RequirementCategory, foreign_key: :future_faculty_requirement_category_id

  has_many :activities, class_name: Participant::Activity
end
