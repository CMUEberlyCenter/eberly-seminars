require 'rubygems'
require 'prawn'

Prawn::Document.generate( "teaching-development-transcript-bg.pdf",
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
                          ) do
  
  font_path = "/home/merichar/ag/app/assets/fonts"
  font_families.update("OpenSans" => {
                         :normal => "#{font_path}/OpenSans-Light-webfont.ttf" ,
                         :bold   => "#{font_path}/OpenSans-Semibold-webfont.ttf" 
                       })


  default_text_color ="010101"
  cmu_red = "990000"
  section_stroke_color = 'bbbbbb'
  section_fill_color = 'f0f0f0'
  

  font "OpenSans"

  # Header
  repeat :all do
    fill_color cmu_red
    text "Teaching Development Transcript", :style => :bold, :size => 24

    fill_color default_text_color
    text "This transcript documents activities with the Eberly Center for Teaching Excellence"
    image "eberly-wordmark.png", :at => [cursor, bounds.top + 5], :height => 40

    #move_down 10
    #fill_color cmu_red
    #text "<b>Margaret Richards</b> | OTE: Office of Technology for Education", :inline_format => true, :size => 16
  end


  # Section labels & backgrounds
  repeat( :all ) do
    fill_color section_fill_color
    stroke_color section_stroke_color
    fill_and_stroke_rectangle [0,450], 240, 385
    fill_and_stroke_rectangle [250,450], bounds.right-250, 275
    fill_and_stroke_rectangle [250,155], bounds.right-250, 90

    fill_color cmu_red
    font_size( 13 ) do
      draw_text "Individual Consultations and Feedback", :at => [0,450], :width => 240
      draw_text "Seminars on Teaching", :at => [250,450], :width => bounds.right-250
      draw_text "Additional Teaching Development and Special Notes", :at => [250,155], :width => bounds.right-250
    end
  end


  # Footer
  repeat :all do
    footer_y = 36
    footer_text_width = 136
    image "carnegie-mellon-wordmark-inverse.jpg", :at => [0,footer_y], :height => 20
    fill_color default_text_color
    bounding_box [bounds.right-footer_text_width, footer_y], 
                 :width => footer_text_width, :height => footer_y do
      font_size( 9 ) do
        text "www.cmu.edu/teaching", :size => 12, :character_spacing => 0.5
        move_down 2
        text "eberly-ctr@andrew.cmu.edu", :character_spacing => 0.5
        move_down 2
        text "412-268-2896", :character_spacing => 0.5
      end
    end
  end
 

end
