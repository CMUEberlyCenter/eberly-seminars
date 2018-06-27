prawn_document(
  :filename=>"#{@participant.andrewid}-transcript-#{Time.now.strftime('%Y_%m_%d')}.pdf",
  :info => {
                             :Title => "Teaching Development Transcript",
                             :Author => "Eberly Center for Teaching Excellence - Carnegie Mellon University",
                             :Creator => "Graduate Student Services Application",
                             :CreationDate => Time.now
                           },
                           :page_layout => :portrait,
                           :top_margin => 50,
                           :right_margin => 65,
                           :bottom_margin => 20,
                           :left_margin => 65

) do |pdf|
  default_text_color ="010101"
  #default_stroke_color = "aaaaaa"
  default_stroke_color = "cccccc"
  cmu_red = "990000"
  title_font_size = 18
  body_font_size = 12
  name_font_size = 16
  #footer_large_font_size = 12
  footer_font_size = 9

  pdf.font_families.update("OpenSans" => {
                         :normal => "app/assets/fonts/OpenSans-Light-webfont.ttf",
                         :bold   => "app/assets/fonts/OpenSans-Semibold-webfont.ttf"
                       })
  pdf.font "OpenSans"

  # Header
  pdf.repeat :all do
    pdf.fill_color cmu_red
    pdf.text "Transcript of\nTeaching Development Activities", :style => :bold, :size => title_font_size

    pdf.image "app/assets/images/eberly-wordmark.png", :at => [pdf.bounds.left+350, pdf.bounds.top ], :height => 30
    pdf.move_down 5
    pdf.stroke_color default_stroke_color
    pdf.stroke do
      pdf.horizontal_rule
    end


    pdf.move_down 10
    pdf.fill_color cmu_red
    pdf.text "<b>" + @participant.name + "</b> " + Array.[](@participant.department).flatten.join(', '), :inline_format => true, :size => name_font_size

    pdf.move_down 10
  end


  pdf.fill_color cmu_red
  pdf.move_down 7

  y_position=pdf.cursor
  pdf.bounding_box([0, y_position], :width => 450, :height => 500) do


    pdf.text "Seminars", :size => name_font_size
    pdf.fill_color default_text_color
    pdf.move_down 2
    pdf.text "Each seminar integrates educational research and pedagogical strategies", :size => 9

    pdf.move_down 10

  if @participant.attended_seminars.size > 0
    @participant.attended_seminars.each do |s|
      title = "#{s.title}"
      if s.core?
        title = "#{title}\*"
      end

      pdf.text "#{title}  [ #{s.start_at.strftime("%b %d, %Y")} ]"
      pdf.move_down 10
    end
  else
    pdf.text "N/A"
  end

  pdf.move_down 10

  pdf.fill_color cmu_red

  pdf.text "Workshops and Other Programming", :size => name_font_size
  pdf.fill_color default_text_color
  pdf.move_down 2
  pdf.text "Each workshop provides immediate feedback to participants",  :size => 9

  pdf.move_down 15

  workshops_and_other = @participant.attended_workshops + @participant.attended_other
  if workshops_and_other.size > 0
    workshops_and_other.each do |s|
      title = "#{s.title}"
      if s.core?
        title = "#{title}\*"
      end

      pdf.text "#{title}  [ #{s.start_at.strftime("%b %d, %Y")} ]"
      pdf.move_down 10
    end
  else
    pdf.text "N/A"
  end

  pdf.move_down 15

  pdf.fill_color cmu_red


if Programs::FutureFaculty::Enrollment.find( @participant ).nil?
  category_requirements = Programs::FutureFaculty::RequirementsVersion.find(2).requirements.group_by(&:requirement_category)
else
  category_requirements = @participant.future_faculty_enrollment.requirements.group_by(&:requirement_category)
end

 categories = []
 if @participant.future_faculty_enrollment.nil?
  categories = Programs::FutureFaculty::RequirementsVersion.find(2).categories
 else
  categories = @participant.future_faculty_enrollment.categories
end

 #@participant.future_faculty_enrollment.categories.each do |c|
 categories.each do |c|
  pdf.text c.label, :size => name_font_size
  pdf.fill_color default_text_color
  pdf.move_down 2


  pdf.move_down 15

  if category_requirements[c].size > 0
    category_requirements[c].each do |r|
      if @participant.activities.where("type=\"#{r.activity_class}\"").size > 0
        @participant.activities.where("type=\"#{r.activity_class}\"").each do |a|
          if a.completed_on
            pdf.text "#{r.label} [ #{a.completed_on.strftime('%b %d, %Y')} ]"
            pdf.move_down 5
            if a.course
              pdf.text "Course: #{a.course}"
              pdf.move_down 5
            end

            pdf.move_down 5
          end
        end
      end
    end

  end
  pdf.move_down 15

  pdf.fill_color cmu_red
  pdf.move_down 10

 end #c
#end



  pdf.text "Other Activities and Consultations", :size => name_font_size
  pdf.fill_color default_text_color
  pdf.move_down 2
  #pdf.text "Each seminar is 1.5-2 hours long and integrates educational research and pedagogical strategies", :style => :bold, :size => 8

  pdf.move_down 15
  if @participant.activities and @participant.activities.additional and @participant.activities.additional.size > 0
    @participant.activities.additional.find_each do |a|
      title = "#{a.title}"
      pdf.text "#{title}  #{a.completed_on ? '[ '+a.completed_on.strftime('%b %d, %Y')+' ]' : ''}"
      pdf.move_down 5
      pdf.text "#{a.description}"
      pdf.move_down 10
    end

  else
    pdf.text "N/A"
  end

  end

  pdf.move_down 15


  # Footer
  pdf.repeat :all do
    pdf.move_to 0,60
    pdf.fill_color cmu_red
    pdf.bounding_box [pdf.bounds.left,60],
                 :width => pdf.bounds.right-pdf.bounds.left, :height => 10 do
    pdf.text "This transcript documents activities with the Eberly Center for Teaching Excellence & Educational Innovation", :size => 8, :align => :center
    end
    pdf.move_to 0,45
    pdf.stroke_color default_stroke_color
    pdf.line_to pdf.bounds.right-pdf.bounds.left,45
    pdf.stroke

    footer_y = 45
#    pdf.stroke do
      #pdf.horizontal_rule
 #   end

    footer_y = 36
    footer_text_width = 268
    pdf.image "app/assets/images/carnegie-mellon-wordmark-inverse.png", :at => [0,footer_y-2], :height => 18
    pdf.fill_color cmu_red
    pdf.bounding_box [pdf.bounds.right - footer_text_width, footer_y - 7],
                 :width => footer_text_width, :height => footer_y do
      pdf.font_size( footer_font_size ) do
        pdf.text "www.cmu.edu/teach   eberly-ctr@andrew.cmu.edu   412-268-2896"
      end
    end
  end

  pdf.default_leading 0

end
