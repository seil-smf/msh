# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowMonitorCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        if command_args[:monitor_id]
          api = Msh::Api::GETUserUserCodeMonitorId.new({
                                                         :id => command_args[:monitor_id]
                                                     })
        else
          api = Msh::Api::GETUserUserCodeMonitor.new
        end

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          if api.class == Msh::Api::GETUserUserCodeMonitor
            res_json = json_load(response.body)["results"]
            $output.puts "---"
            res_json.each_with_index do |monitor, i|
              $output.puts "- Monitor_#{i}:"
              $output.puts "    MonitorGroup ID: #{monitor["id"]}"
              $output.puts "    MonitorGroup Name: #{monitor["name"]}"
              $output.puts "    Member: #{monitor["member"]}"
            end
          else
            monitor = json_load(response.body)
            $output.puts "---"
            $output.puts "MonitorGroup ID: #{monitor["id"]}"
            $output.puts "MonitorGroup Name: #{monitor["name"]}"
            $output.puts "  Reports:"
            monitor["reports"].each_with_index do |report, i|
              $output.puts "    Report_#{i}: #{report["address"] if report}"
            end
            $output.puts "  SA:"
            monitor["sa"].each_with_index do |sa, i|
              $output.puts "    SA_#{i} Code: #{sa["code"]}"
              $output.puts "    SA_#{i} Name: #{sa["name"]}"
            end
          end
        end

      end

      private

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                      })
        end

        def parse_optional_args(args)
          self[:monitor_id] = args.shift unless args.empty?
        end
      end

    end
  end
end
