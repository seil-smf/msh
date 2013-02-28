# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class UnknownCommandCommand
      def doit(command_array)
        $output.puts command_array.join(' ') + ' is unknown command.'
      end
    end
  end
end

