# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class AddMonitorCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeMonitor.new({
                                                      :user_code => $conf[:user_code],
                                                    })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          monitor = json_load(response.body)
          $output.puts "---"
          $output.puts "MonitorGroup ID: #{monitor["id"]}"
          $output.puts "MonitorGroup Name: #{monitor["name"]}"
        end

      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :name => request_param[:monitor_name]
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command      => args.shift,
                        :subcommand   => args.shift,
                        :monitor_name  => args.shift,
                      })
        end

        def parse_optional_args(args)
          #nothing to do.
        end

      end

    end
  end
end
