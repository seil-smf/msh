# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class SetModuleCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::PUTUserUserCodeSaSaCodeConfigWorkingModuleId.new({
                                                                           :user_code => $conf[:user_code],
                                                                           :sa => command_args[:sa],
                                                                           :id => command_args[:module_id],
                                                                         })

        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        $output.puts "module: Module version was updated to #{command_args[:version]}."

#        puts_response(response)
      end

      private

      def set_request_param(request_param)
        @request[:request]           = { }
        @request[:request][:version] = request_param[:version] if request_param[:version]
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :sa => args.shift,
                        :module_id => args.shift,
                        :version => args.shift,
                      })
        end

        def parse_optional_args(args)
          # nothing to do.
        end

      end
    end

  end
end



