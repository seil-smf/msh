# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class UnsetEnvCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        $conf = env_unset(command_args)

        $conf.puts_conf
      end

      private

      def env_unset(command_args)
        conf_clone = $conf.clone

        command_args[:unset_params].each {|unset_param|
          conf_clone[unset_param] = nil
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
          self[:unset_params] = []
          until args.empty?
            self[:unset_params] << args.shift.to_sym
          end
        end
      end

    end
  end
end
