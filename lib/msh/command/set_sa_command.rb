# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class SetSaCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::PUTUserUserCodeSaSaCode.new({
                                                      :sa => command_args[:sa]
                                                    })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        res_json = json_load(response.body)
        sa = json_load(response.body)
        $output.puts "---"
        $output.puts "SA Code: #{sa["code"]}"
        $output.puts "SA Label: #{sa["name"]}"
        $output.puts "Description: #{sa["description"]}"
        $output.puts "Distribution ID: #{sa["distributionId"]}"
        $output.puts "Preferred Push Method: #{sa["preferredPushMethod"]}"
        $output.puts "Up: #{sa["up"]}"

#        puts_response(response)
      end

      private

      def set_request_param(request_param)
        @request[:request]                       = { }
        @request[:request][:name]                = request_param[:sa_name] if request_param[:sa_name]
        @request[:request][:description]         = request_param[:description] if request_param[:description]
        @request[:request][:distributionId]      = request_param[:distributionid] if request_param[:distributionid]
        @request[:request][:preferredPushMethod] = request_param[:preferredpushmethod] if request_param[:preferredpushmethod]
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :sa => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('name')
            args.delete_at(idx)
            self[:sa_name] = args.delete_at(idx)
          end

          if idx = args.index('description')
            args.delete_at(idx)
            self[:description] = args.delete_at(idx)
          end

          if idx = args.index('distributionid')
            args.delete_at(idx)
            self[:distributionid] = args.delete_at(idx)
          end

          if idx = args.index('preferredpushmethod')
            args.delete_at(idx)
            self[:preferredpushmethod] = args.delete_at(idx)
          end
        end
      end

    end
  end
end
