module Sprout
  class Input
    @foreground : SDL::Color
    @background : SDL::Color

    property :contents, :cursor_position, :height
    getter :blink_visible
    @contents = ""
    @cursor_position = 0
    @blink_visible = false
    @prompt = "→ "
    @cursor = "_"

    def initialize(@foreground, @background)
    end

    def <<(char : Char)
      @contents = @contents.insert(@cursor_position, char)
      @cursor_position += 1
    end

    def backspace
      if @contents.size == 0
        @contents = ""
        @cursor_position = 0
      else
        @contents = @contents.rchop
        @cursor_position -= 1
      end
    end

    def click(position)
    end

    def draw_to_surface
      text_to_draw = @contents
      if @blink_visible
        text_to_draw = @contents.insert(@cursor_position, @cursor)
      end

      Sprout::FONT_SCPRO.render_shaded(@prompt + text_to_draw, @foreground, @background, false)
    end

    def toggle_blink
      @blink_visible = !@blink_visible
    end
  end
end
