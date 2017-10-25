module Sprout
  class Input
    @foreground : SDL::Color
    @background : SDL::Color

    property :contents, :cursor_position, :height
    getter :blink_visible
    @contents = ""
    @cursor_position = 0
    @blink_visible = true
    @prompt = "→ "

    def initialize(@foreground, @background)
    end

    def <<(char : Char)
      @blink_visible = true
      @contents = @contents.insert(@cursor_position, char)
      @cursor_position += 1
    end

    def backspace
      @blink_visible = true
      if @contents.size == 0
        @contents = ""
        @cursor_position = 0
      else
        @contents = @contents[0...@cursor_position].rchop + @contents[@cursor_position..-1]
        @cursor_position -= 1
      end

      if @cursor_position < 0
        @cursor_position = 0
      end
    end

    def cursor_bounds
      if @cursor_position < 0
        @cursor_position = 0
      end

      if @cursor_position > @contents.size
        @cursor_position = @contents.size
      end
    end

    def jump_to(position)
      @cursor_position = position
      cursor_bounds
    end

    def draw_to_surface
      Sprout::FONT_SCPRO.render_shaded(@prompt + @contents, @foreground, @background, false)
    end

    def draw_cursor(renderer, rect)
      return unless @blink_visible
      renderer.draw_color = @foreground
      x = 21 * (@cursor_position + 2)
      renderer.draw_rect(rect.x + x, rect.y + 4, 2, rect.h - 8)
    end

    def toggle_blink
      @blink_visible = !@blink_visible
    end

    def move_cursor(amount : Int32)
      @blink_visible = true
      @cursor_position += amount
      @cursor_position = @contents.size if @cursor_position > @contents.size
      @cursor_position = 0 if @cursor_position < 0
    end
  end
end
