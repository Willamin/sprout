require "sdl"
require "sdl/ttf"
require "nth"

require "./sprout/*"

SDL.init(SDL::Init::VIDEO)
SDL::TTF.init; at_exit { SDL::TTF.quit }

module Sprout
  GREEN          = SDL::Color[128, 160, 128, 255]
  DARK           = SDL::Color[45, 42, 46, 255]
  LIGHT          = SDL::Color[252, 252, 250, 255]
  FONT_HELVETICA = SDL::TTF::Font.new("#{__DIR__}/../res/Helvetica.ttc", 35)
  FONT_SCPRO     = SDL::TTF::Font.new("#{__DIR__}/../res/SourceCodePro-Regular.ttf", 35)
end

window = Sprout::Window.new

window.draw
