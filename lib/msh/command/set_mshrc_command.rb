# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class SetMshrcCommand < AbstractCommand
      MSHRC_DIR_PATH = "#{ENV["HOME"]}/.msh/"

      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        # command_args.parse_optional_args(command_array)
        set_mshrc(command_args[:mshrc])
      end

      private

      def set_mshrc(filename)
        $conf.set_mshrc(MSHRC_DIR_PATH + filename)
        begin
          $conf.read
          $conf.puts_conf
        rescue => e
          p e
        end
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self[:commnad] = args.shift
          self[:subcommnad] = args.shift
          self[:mshrc] = args.shift
        end

        def parse_optional_args(args)
          # nothing to do.
        end
      end

    end
  end
end
