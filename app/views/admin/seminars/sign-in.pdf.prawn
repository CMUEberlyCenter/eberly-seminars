prawn_document(
  :info => {
                             :Title => "Sign-In Sheet - @seminar.title - @seminar.formatted_timespan_short",
                             :Author => "Eberly Center for Teaching Excellence - Carnegie Mellon University",
                             :Creator => "Graduate Student Services Application",
                             :CreationDate => Time.now
                           },
			   :page_layout => :portrait,
                           :top_margin => 50,
                           :right_margin => 70,
                           :bottom_margin => 20,
                           :left_margin => 70

) do |pdf|
  default_text_color ="010101"
  cmu_red = "990000"
  title_font_size = 24
  body_font_size = 12
  name_font_size = 14
  footer_large_font_size = 12
  footer_font_size = 9

  pdf.font_families.update("OpenSans" => {
                         :normal => "app/assets/fonts/OpenSans-Light-webfont.ttf",
                         :bold   => "app/assets/fonts/OpenSans-Semibold-webfont.ttf"
                       })
  pdf.font "OpenSans"

  # Header
  pdf.repeat :all do
    pdf.image "app/assets/images/eberly-wordmark.png", :at => [pdf.bounds.left, pdf.bounds.top+15], :height => 40
    pdf.move_down 45

    pdf.fill_color cmu_red
    pdf.text @seminar.title, :style => :bold, :size => title_font_size
    pdf.move_down 2

    pdf.fill_color default_text_color
    pdf.text  'Attendance Sheet | <b>' + @seminar.formatted_timespan_safe + '</b>', :inline_format => true, :size => name_font_size

  end

  # Footer
  pdf.repeat :all do
    footer_y = 36
    footer_text_width = 136
    pdf.image "app/assets/images/carnegie-mellon-wordmark-inverse.png", :at => [0,footer_y], :height => 20
    pdf.fill_color default_text_color
    pdf.font_size( footer_font_size ) do
      pdf.draw_text "Printed " + Time.now.strftime("%b %e, %G %l:%M %P"), :at => [0,footer_y-30]
    end
    pdf.bounding_box [pdf.bounds.right-footer_text_width, footer_y],
                 :width => footer_text_width, :height => footer_y do
      pdf.font_size( footer_font_size ) do
        pdf.text "www.cmu.edu/teaching", :size => footer_large_font_size, :character_spacing => 0.5
        pdf.move_down 2
        pdf.text "eberly-ctr@andrew.cmu.edu", :character_spacing => 0.5
        pdf.move_down 2
        pdf.text "412-268-2896", :character_spacing => 0.5
      end
    end
  end


  pdf.fill_color = '000000'
  pdf.stroke_color = 'cccccc'

  pdf.default_leading 20

  pdf.bounding_box [0, pdf.bounds.top-120], :width => 200, :height => 550 do
    participants = @seminar.registrations.confirmed.all.collect {|r| r.participant }
    participants.sort_by(&:surname).each do |p|

      pdf.text p.name
      pdf.stroke do
        pdf.horizontal_line 0, 450, :at => pdf.cursor+15
	pdf.vertical_line pdf.cursor+48, pdf.cursor+15, :at => 200
      end

    end
  end

  pdf.default_leading 0

end
