class SeminarGroup
  attr_accessor :title, :css_class, :seminars

  def to_partial_path() "seminars/seminar_group" end

  def initialize(attributes = {})
    @title, @css_class, @seminars = 
      *attributes.values_at(:title, :css_class, :seminars)
  end
end
