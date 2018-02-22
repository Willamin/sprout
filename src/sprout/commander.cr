module Sprout
  class Commander
    def initialize(command = "")
      @command = command
    end

    def run
      tokens = @command.split(" ")
      action = tokens[1.st]
      params = tokens[2.nd..-1].join(" ")

      case action
      when "o", "open"
        open params
      when "t", "term"
        term params
      else
        puts "running #{@command}"
      end
    end

    def open(params)
      puts "opening finder to: #{params}"
      system("open -a Finder -- #{params}")
    end

    def term(params)
      puts "running in terminal: #{params}"
    end
  end
end
