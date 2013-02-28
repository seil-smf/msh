# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class AddSaGroupCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeSagroup.new({ })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          sagroup = json_load(response.body)
          $output.puts "---"
          $output.puts "SaGroup ID: #{sagroup["id"]}"
          $output.puts "SaGroup Name: #{sagroup["name"]}"
        end

      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :name => request_param[:sagroup_name]
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command      => args.shift,
                        :subcommand   => args.shift,
                        :sagroup_name  => args.shift,
                      })
        end

        def parse_optional_args(args)
          #nothing to do.
        end

      end

    end
  end
end
