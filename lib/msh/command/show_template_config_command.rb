# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowTemplateConfigCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        api = Msh::Api::GETUserUserCodeTemplateIdConfigModuleIdPlain.new({
                                                                           :user_code => $conf[:user_code],
                                                                           :template_id => command_args[:template_id],
                                                                           :module_id => command_args[:module_id]
                                                                         })
        response = execute(api)
        return unless check_http_success(response)

        puts_response(response)
      end

      private

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :template_id => args.shift,
                        :module_id => args.shift,
                      })
        end

        def parse_optional_args(args)
          # nothing to do.
        end

      end

    end
  end
end
