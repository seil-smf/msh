# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class TracerouteCommand < AbstractCommand
      REQUEST_TRACEROUTE_MAXHOP = 30
      REQUEST_TRACEROUTE_COUNT  = 3

      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeRequestTraceroute.new({
                                                                :user_code => $conf[:user_code],
                                                              })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)
        return if has_targetTime?(command_args, response)
        traceroute_id = json_load(response.body)['id']

        api = Msh::Api::GETUserUserCodeRequestTracerouteId.new({
                                                                 :user_code => $conf[:user_code],
                                                                 :id => traceroute_id
                                                               })

        response = execute_poll(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          traceroute = json_load(response.body)
          if traceroute["status"] == "successed"
            $output.puts "traceroute to #{traceroute["targetAddress"]}, #{traceroute["maxHop"]} hops max, #{traceroute["count"]} packets"
            traceroute["resultNodeInfo"].each do |node|
              $output.puts " #{node["hop"]} #{node["address"]}"
            end
          else
            $output.puts "traceroute: failed."
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
          :maxHop        => request_param[:maxHop],
          :count         => request_param[:count]
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command       => args.shift,
                        :sa => args.shift,
                        :targetAddress => args.shift
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('maxhop')
            args.delete_at(idx)
            self[:maxHop] = args.delete_at(idx)
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
          self[:maxHop]     ||= REQUEST_TRACEROUTE_MAXHOP
          self[:count]      ||= REQUEST_TRACEROUTE_COUNT
        end
      end

    end
  end
end
