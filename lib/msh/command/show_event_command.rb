# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowEventCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::GETUserUserCodeEvent.new({
                                                   :user_code => $conf[:user_code],
                                                 })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        puts_response(response)
      end

      private

      def puts_response(response)
        if @verbose
          super
        else
          res_json = json_load(response.body)["results"]
          $output.puts "---"
          res_json.each_with_index do |event,i|
            $output.puts "- Event_#{i}:"
            $output.puts "    Event ID: #{event["id"]}"
            $output.puts "    Event Type: #{event["type"]}"
            $output.puts "    Event SubType: #{event["subtype"]}"
            $output.puts "    SA: "
            event["sa"].each_with_index do |sa, j|
              $output.puts "     SA_#{j} Code: #{sa["code"]}"
              $output.puts "     SA_#{j} Name: #{sa["name"]}"
            end
          end
        end
      end

      def set_request_param(request_param)
        @request[:request] ||= { }
        @request[:request][:sacode] = request_param[:sa] if request_param[:sa]
        @request[:request][:type]   = request_param[:type] if request_param[:type]
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift
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
        end
      end

    end
  end
end
