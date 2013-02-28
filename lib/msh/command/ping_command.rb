# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class PingCommand < AbstractCommand
      REQUEST_PING_SIZE = 56
      REQUEST_PING_COUNT = 5

      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeRequestPing.new({ })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)
        return if has_targetTime?(command_args, response)
        ping_id = json_load(response.body)['id']

        api = Msh::Api::GETUserUserCodeRequestPingId.new({
                                                           :id => ping_id
                                                         })

        response = execute_poll(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
         ping = json_load(response.body)
          if ping["status"] == "successed"
            $output.puts "#{ping["count"]} packets transmitted, #{ping["resultSuccess"]} packets received, #{100.0 * ping["resultFailure"] / ping["count"]}% packet loss"
          else
            $output.puts "ping: failed."
          end
        end

      end


      private

      def set_request_param(request_param)
        @request[:request] = {
          :sa            => {
            :code => request_param[:sa]
          },
          :targetTime    => request_param[:targetTime],
          :targetAddress => request_param[:targetAddress],
          :size          => request_param[:size],
          :count         => request_param[:count]
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
            :command       => args.shift,
            :sa => args.shift,
            :targetAddress => args.shift,
          })
        end

        def parse_optional_args(args)
          if idx = args.index('size')
            args.delete_at(idx)
            self[:size] =  args.delete_at(idx)
          end

          if idx = args.index('count')
            args.delete_at(idx)
            self[:count] = args.delete_at(idx)
          end

          if idx = args.index('targettime')
            args.delete_at(idx)
            self[:targetTime] = [args.delete_at(idx), args.delete_at(idx)].join(' ')
          end

          self[:targetTime] ||= Msh::Constants::REQUEST_TARGET_TIME
          self[:size]       ||= REQUEST_PING_SIZE
          self[:count]      ||= REQUEST_PING_COUNT
        end

      end
    end
  end
end
