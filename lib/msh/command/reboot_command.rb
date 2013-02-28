# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class RebootCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeRequestReboot.new({
                                                         })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          $output.puts "reboot: task was registered."
        end

      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :sa         => {
            :code => request_param[:sa]
          },
          :targetTime => request_param[:targetTime],
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command => args.shift,
                        :sa => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('sa')
            args.delete_at(idx)
            self[:sa] = args.delete_at(idx)
          end

          if idx = args.index('targettime')
            args.delete_at(idx)
            self[:targetTime] = [args.delete_at(idx), args.delete_at(idx)].join(' ')
          end

          self[:targetTime] ||= Msh::Constants::REQUEST_TARGET_TIME
        end
      end

    end
  end
end

