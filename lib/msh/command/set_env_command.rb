# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class SetEnvCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        $conf = env_set(command_args)

        $conf.puts_conf
      end

      private

      def env_set(command_args)
        conf_clone = $conf.clone

        command_args[:set_params].each {|k, v|
          conf_clone[k] = v
        }
        conf_clone
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                      })
        end

        def parse_optional_args(args)
          self[:set_params] = { }
          until args.empty?
            self[:set_params][args.shift.to_sym] = args.shift
          end
        end
      end

    end
  end
end
