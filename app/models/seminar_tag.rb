class SeminarTag < ActiveRecord::Base
  belongs_to :seminar

  validates :value, uniqueness: { scope: :seminar,
                                  case_sensitive: false,
                                  message: "already has this tag" }
end
