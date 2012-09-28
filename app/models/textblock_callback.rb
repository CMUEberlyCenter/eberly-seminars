require 'prawn_rails'

# Callback function used by transcript pdf generation to
# draw background and labels for content sections.
class TextblockCallback
  def initialize(options)
    @top_left = options[:top_left]
    @width = options[:width]
    @height = options[:height]
    @label = options[:label]
    
    @document = options[:document]
    
    @page = @document.page_number
    @box_drawn = false
  end
  
  def render_behind(fragment)
    original_color = @document.fill_color
    original_stroke = @document.stroke_color
    @document.fill_color = 'f0f0f0'
    @document.stroke_color = 'bbbbbb'
    
    if @box_drawn
      if @page != @document.page_number
        @box_drawn = false
        @page = @document.page_number
      end
    end
    
    unless @box_drawn
      @document.fill_and_stroke_rectangle( @top_left, @width, @height )
      @document.font_size( 13 ) do
        @document.fill_color = '990000'
        @document.draw_text @label, :at => [-20,@height-20], :width => 240
      end
      @box_drawn = true
    end
    
    @document.fill_color = original_color
    @document.stroke_color = original_stroke
  end
end
