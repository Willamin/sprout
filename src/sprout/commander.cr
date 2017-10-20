module Sprout
  class Commander
    def initialize(command = "")
      @command = command
    end

    def run
      puts "running #{@command}"
    end
  end
end
