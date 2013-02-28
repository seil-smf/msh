# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class CheckTransactionCommand < AbstractCommand
      def doit(command_array)
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        clear_request
        set_api("/user/#{$conf[:user_code]}/request/check-transaction")
        set_method(:POST)
        set_content_type('application/json')
        set_request_param(command_args)

        response = execute(@request)
        return unless check_http_success(response)
        return if has_targetTime?(command_args, response)
        check_transaction_id = json_load(response.body)['id']

        clear_request
        set_api("/user/#{$conf[:user_code]}/request/check-transaction/#{check_transaction_id}")
        set_method(:GET)

        response = execute_poll(@request)
        return unless check_http_success(response)
        puts_response(response)
      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :sa => {
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
          if idx = args.index('targettime')
            self[:targetTime] = [args[idx + 1], args[idx + 2]].join(' ')
          end

          self[:targetTime] ||= Msh::Constants::REQUEST_TARGET_TIME

        end
      end

    end
  end
end

