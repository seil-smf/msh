# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowMshrcCommand < AbstractCommand
      MSHRC_DIR_PATH = "#{ENV["HOME"]}/.msh/"

      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        command_args.parse_optional_args(command_array)

        if command_args[:mshrc]
          show_mshrc(command_args[:mshrc])
        else
          show_mshrc_dir
        end
      end

      private

      def show_mshrc(filename)
        if File.exist?(MSHRC_DIR_PATH + filename)
          File.open(MSHRC_DIR_PATH + filename) do |f|
            $output.puts f.read
          end
        end
      end

      def show_mshrc_dir
        Dir.entries(MSHRC_DIR_PATH).grep(/\Amshrc(\z|\.)/).sort.each do |mshrc_file|
          $output.puts mshrc_file
        end
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self[:commnad] = args.shift
          self[:subcommnad] = args.shift
        end

        def parse_optional_args(args)
          self[:mshrc] = args.shift unless args.empty?
        end
      end

    end
  end
end
