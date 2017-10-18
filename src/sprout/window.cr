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
      @input = Input.new(@foreground, @background)
    end

    def draw
      spawn do
        blink_loop
      end
      main_loop
    end

    def clear
      @renderer.draw_color = @background
      @renderer.clear
    end

    def blink_loop
      loop do
        @input.toggle_blink
        sleep 0.5
      end
    end

    def main_loop
      loop do
        Fiber.yield
        case handle_event(SDL::Event.poll)
        when :break
          break
        end
        clear
        surface = @input.draw_to_surface
        x = 25
        y = (@window.height - surface.height) / 2
        @renderer.copy(surface, dstrect: SDL::Rect[x, y, surface.width, surface.height])
        @renderer.present
      end
    end

    def handle_event(event)
      case event
      when SDL::Event::TextInput
        @input << event.text[0].chr
      when SDL::Event::Keyboard
        handle_keyboard_event(event)
      when SDL::Event::MouseButton
        handle_mouse_event(event)
      when SDL::Event::Window
        if event.event == 13
          :break
        end
      when SDL::Event::Quit
        :break
      end
    end

    def handle_keyboard_event(event : SDL::Event::Keyboard)
      if (event.keyup? || event.repeat != 0)
        case event.sym
        when LibSDL::Keycode::BACKSPACE
          @input.backspace
        when LibSDL::Keycode::RETURN
          Commander.new(@input.contents).run
          :break
        when LibSDL::Keycode::ESCAPE
          :break
        end
      end
    end

    def handle_mouse_event(event : SDL::Event::MouseButton)
      if event.pressed?
        # @input.click(event)
      end
    end
  end
end
