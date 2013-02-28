# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class DoExitCommand
      def doit(command_array)
        exit
      end
    end
  end
end
