# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class AddTemplateVariableCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeTemplateIdVariable.new({
                                                                 :id => command_args[:template_id]
                                                               })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          template_variable = json_load(response.body)
          $output.puts "---"
          $output.puts "TemplateVariable Name: #{template_variable["name"]}"
          $output.puts "TemplateVariable DefaultValue: #{template_variable["defaultValue"]}"
        end

      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :name => request_param[:template_variable_name],
          :defaultValue => request_param[:default_value]
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command      => args.shift,
                        :subcommand   => args.shift,
                        :template_id  => args.shift,
                        :template_variable_name  => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('defaultvalue')
            args.delete_at(idx)
            self[:default_value] = args.delete_at(idx)
          end
        end

      end

    end
  end
end
