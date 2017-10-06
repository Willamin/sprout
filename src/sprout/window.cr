module Sprout
  class Window
    @background : SDL::Color
    @foreground : SDL::Color

    def initialize
      at_exit { SDL.quit }
      @window = SDL::Window.new("Sprout", 600, 80)
      @window.bordered = false
      @renderer = SDL::Renderer.new(@window)
      @background = Sprout::GREEN
      @foreground = Sprout::LIGHT
    end

    def draw
      loop do
        case event = SDL::Event.wait
        when SDL::Event::Quit
          break
        end

        clear
        draw_left_text("hello")
        @renderer.present
      end
    end

    def clear
      @renderer.draw_color = @background
      @renderer.clear
    end

    def draw_centered_text(string : String)
      surface = Sprout::FONT_HELVETICA.render_shaded(string, @foreground, @background)
      x = (@window.width - surface.width) / 2
      y = (@window.height - surface.height) / 2
      @renderer.copy(surface, dstrect: SDL::Rect[x, y, surface.width, surface.height])
    end

    def draw_left_text(string : String)
      surface = Sprout::FONT_HELVETICA.render_shaded(string, @foreground, @background)
      x = 25
      y = (@window.height - surface.height) / 2
      @renderer.copy(surface, dstrect: SDL::Rect[x, y, surface.width, surface.height])
    end
  end
end
