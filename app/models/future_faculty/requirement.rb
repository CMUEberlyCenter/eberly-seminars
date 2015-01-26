class FutureFaculty::Requirement < ActiveRecord::Base
  belongs_to :requirements_version, class_name: FutureFaculty::RequirementsVersion, foreign_key: :future_faculty_requirements_version_id
  belongs_to :requirement_category, class_name: FutureFaculty::RequirementCategory, foreign_key: :future_faculty_requirement_category_id
end
