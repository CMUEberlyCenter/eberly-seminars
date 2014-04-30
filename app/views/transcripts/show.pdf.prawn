@attended_seminars=[]
prawn_document(
  :filename=>"#{@participant.andrewid}-transcript-#{Time.now.strftime('%Y_%m_%d')}.pdf",
  :info => {
                             :Title => "Teaching Development Transcript",
                             :Author => "Eberly Center for Teaching Excellence - Carnegie Mellon University",
                             :Creator => "Graduate Student Services Application",
                             :CreationDate => Time.now
                           },
                           :page_layout => :landscape,
                           :top_margin => 50,
                           :right_margin => 70,
                           :bottom_margin => 20,
                           :left_margin => 70

) do |pdf|
  default_text_color ="010101"
  cmu_red = "990000"
  title_font_size = 24
  body_font_size = 12
  name_font_size = 16
  footer_large_font_size = 12
  footer_font_size = 9

  pdf.font_families.update("OpenSans" => {
                         :normal => "app/assets/fonts/OpenSans-Light-webfont.ttf",
                         :bold   => "app/assets/fonts/OpenSans-Semibold-webfont.ttf"
                       })
  pdf.font "OpenSans"

  # Header
  pdf.repeat :all do
    pdf.fill_color cmu_red
    pdf.text "Teaching Development Transcript", :style => :bold, :size => title_font_size

    pdf.fill_color default_text_color
    pdf.text "This transcript documents activities with the Eberly Center for Teaching Excellence"
    pdf.image "app/assets/images/eberly-wordmark.png", :at => [pdf.cursor, pdf.bounds.top + 5], :height => 40

    pdf.move_down 10
    pdf.fill_color cmu_red
    pdf.text "<b>" + @participant.name + "</b> | " + Array.[](@participant.department).flatten.join(', '), :inline_format => true, :size => name_font_size
  end

  # Footer
  pdf.repeat :all do
    footer_y = 36
    footer_text_width = 136
    pdf.image "app/assets/images/carnegie-mellon-wordmark-inverse.jpg", :at => [0,footer_y], :height => 20
    pdf.fill_color default_text_color
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

  # Content Boxes
  pdf.fill_color = '000000'
  pdf.default_leading 10
  textblock_padding = 20

  # Consultations Content Box [0,450], 240, 385
  consultations_left = 0 + textblock_padding
  consultations_top  = 450 - textblock_padding
  consultations_width = 240 - 2*textblock_padding
  consultations_height = 385 - 2*textblock_padding
  consultations_bg = TextblockCallback.new(
                                      :top_left => [-textblock_padding, consultations_height + textblock_padding -1],
                                      :width => consultations_width+2*textblock_padding,
                                      :height => consultations_height+2*textblock_padding,
                                      :label => "Individual Consultations and Feedback",
                                      :document => pdf
                                      )
  pdf.float do
    pdf.bounding_box [consultations_left,consultations_top], :width => consultations_width, :height => consultations_height do
      pdf.font_size(body_font_size) do
        pdf.formatted_text [{ :text => "N/A",
                          :callback => consultations_bg
                        }]
      end
    end
  end


  # Seminars Content Box [250,450], pdf.bounds.right-250, 275
  seminars_left = 250 + textblock_padding
  seminars_top  = 450 - textblock_padding
  seminars_width = pdf.bounds.right-250 - 2*textblock_padding
  seminars_height = 275 - 2*textblock_padding
  seminars_bg = TextblockCallback.new(
                                      :top_left => [-textblock_padding, seminars_height + textblock_padding -1],
                                      :width => seminars_width+2*textblock_padding,
                                      :height => seminars_height+2*textblock_padding,
                                      :label => "Seminars on Teaching",
                                      :document => pdf
                                      )
  seminar_text = "N/A"
  if @attended_seminars.size > 0
      seminar_text = @attended_seminars.map { |r| r.seminar.title }.join("\n")
  end
  pdf.float do
    pdf.bounding_box [seminars_left,seminars_top], :width => seminars_width, :height => seminars_height do
      pdf.font_size(body_font_size) do
        pdf.formatted_text [{ :text => seminar_text,
                          :callback => seminars_bg
                        }]
      end
    end
  end

  # Special Content Box [250,155], pdf.bounds.right-250, 90
  special_left = 250 + textblock_padding
  special_top  = 155 - textblock_padding
  special_width = pdf.bounds.right-250 - 2*textblock_padding
  special_height = 90 - 2*textblock_padding
  special_bg = TextblockCallback.new(
                                      :top_left => [-textblock_padding, special_height + textblock_padding -1],
                                      :width => special_width+2*textblock_padding,
                                      :height => special_height+2*textblock_padding,
                                      :label => "Additional Teaching Development and Special Notes",
                                      :document => pdf
                                      )
  pdf.float do
    pdf.bounding_box [special_left,special_top], :width => special_width, :height => special_height do
      pdf.font_size(body_font_size) do
        pdf.formatted_text [{ :text => "N/A",
                          :callback => special_bg
                        }]
      end
    end
  end

  pdf.default_leading 0


end
