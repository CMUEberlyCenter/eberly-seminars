class FutureFaculty::RequirementsVersion < ActiveRecord::Base
  has_many :requirements, class_name: FutureFaculty::Requirement, foreign_key: :future_faculty_requirements_version_id
  has_many :categories, -> { uniq }, through: :requirements, source: :requirement_category
end
