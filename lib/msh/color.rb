require 'colorize'

module Msh
  module Color

    # set "false" if you want to disable colored output
    @@enabled = true

    def success(msg)
      color(msg, :green)
    end

    def info(msg)
      color(msg, :uncolorize)
    end

    def warning(msg)
      color(msg, :yellow)
    end

    def error(msg)
      color(msg, :red)
    end

    def notice(msg)
      color(msg, :light_yellow)
    end

    def important(msg)
      color(msg, :red)
    end

    def url(msg)
      color(msg, :light_blue)
    end

    private

    def color(msg, color)
      if msg != nil && !msg.empty?
        msg.colorize(color)
      else
        ""
      end
    end
  end
end
