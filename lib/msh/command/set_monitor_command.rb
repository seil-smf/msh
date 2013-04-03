# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class SetMonitorCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::PUTUserUserCodeMonitorId.new({
                                                       :user_code => $conf[:user_code],
                                                       :id => command_args[:monitor_id]
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
          $output.puts "Reports:"
          monitor["reports"].each_with_index do |report, i|
            $output.puts "  report #{i}: #{report["address"] if report}"
          end
          $output.puts "SA:"
          monitor["sa"].each_with_index do |sa, i|
            $output.puts "  SA Code #{i}: #{sa["code"]}"
            $output.puts "  SA Name #{i}: #{sa["name"]}"
          end
        end

      end

      private

      def set_request_param(request_param)
        @request[:request]           = { }
        @request[:request][:name]    = request_param[:monitor_name] if request_param[:monitor_name]
        @request[:request][:reports] = request_param[:monitor_reports] if request_param[:monitor_reports]
        @request[:request][:sa]      = request_param[:monitor_sa] if request_param[:monitor_sa]
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :monitor_id => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('name')
            args.delete_at(idx)
            self[:monitor_name] = args.delete_at(idx)
          end

          if idx = args.index('reports')
            self[:monitor_reports] = Array.new
            args.delete_at(idx)
            5.times do
              if args[idx] == 'sa' || args[idx].nil?
                self[:monitor_reports] << {:address => nil}
              else
                self[:monitor_reports] << {:address => args.delete_at(idx)}
              end
            end
          end

          if idx = args.index('sa')
            self[:monitor_sa] = Array.new
            args.delete_at(idx)
            args[idx...args.size].each do |arg|
              break if 'reports' == arg
              self[:monitor_sa] << {:code => arg}
            end
          end
        end
      end

    end
  end
end
