# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowRequestCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        if command_args[:type] && command_args[:type_id]
          request_type = command_args[:type].split(/[\/|_|-]/).map{|token| token.capitalize}.join
          candidate_api = eval "Msh::Api::GETUserUserCodeRequest#{request_type}Id"
          api = candidate_api.new({
                                    :user_code => $conf[:user_code],
                                    :id => command_args[:type_id]
                                  })
        else
          set_request_param(command_args)
          api = Msh::Api::GETUserUserCodeRequest.new({
                                                       :user_code => $conf[:user_code],
                                                     })
          api.request = @request[:request]
        end

        response = execute(api)
        return unless check_http_success(response)

        if command_args[:type] && command_args[:type_id].nil?
          response_tmp = []
          json_load(response.body)['results'].each do |task|
            if task['type'] == command_args[:type]
              JSON.dump(task)
              response_tmp << task
            end
          end
          response.body = JSON.dump({:results => response_tmp})
        end
        if command_args[:type] && command_args[:type_id]
          request = [json_load(response.body)]
        else
          request = json_load(response.body)['results']
        end

        if @verbose
          puts_response(response)
        else
          $output.puts "---"
          request.each_with_index do |task, i|
            $output.puts "- Request_#{i}:"
            $output.puts "    Request ID: #{task["id"]}"
            $output.puts "    Request Type: #{task["type"]}"
            $output.puts "    SA Code: #{task["sa"]["code"]}"
            $output.puts "    SA Name: #{task["sa"]["name"]}"
            $output.puts "    Status: #{task["status"]}"
            $output.puts "    Target Time: #{task["targetTime"]}"
          end
        end
      end

      private

      def set_request_param(request_param)
        @request[:request] ||= { }
        @request[:request][:sacode] = request_param[:sa] if request_param[:sa]
        @request[:request][:status] = request_param[:status] if request_param[:status]
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
          if idx = args.index('sa')
            args.delete_at(idx)
            self[:sa] = args.delete_at(idx)
          end

          if idx = args.index('type')
            args.delete_at(idx)
            self[:type] = args.delete_at(idx)
          end

          if idx = args.index('id')
            args.delete_at(idx)
            self[:type_id] = args.delete_at(idx)
          end

          if idx = args.index('status')
            args.delete_at(idx)
            self[:status] = args
          end
        end
      end

    end
  end
end

