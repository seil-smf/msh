# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class UnsetSaGroupCommand < AbstractCommand
      DEFAULT_SAGROUP_NAME = "SA Group"

      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::PUTUserUserCodeSagroupId.new({
                                                       :user_code => $conf[:user_code],
                                                       :id => command_args[:sagroup_id]
                                                     })
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
          $output.puts "SA:"
          sagroup["sa"].each_with_index do |sa, i|
            $output.puts "  SA Code #{i}: #{sa["code"]}"
            $output.puts "  SA Name #{i}: #{sa["name"]}"
          end
        end

      end

      private

      def set_request_param(request_param)
        @request[:request]        = { }
        @request[:request][:name] = request_param[:sagroup_name] if request_param[:sagroup_name]
        @request[:request][:sa]   = request_param[:sagroup_sa] if request_param[:sagroup_sa]
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :sagroup_id => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('name')
            args.delete_at(idx)
            self[:sagroup_name] = "#{DEFAULT_SAGROUP_NAME}"
          end

          if idx = args.index('sa')
            args.delete_at(idx)
            self[:sagroup_sa] = Array.new
          end
        end
      end

    end
  end
end
