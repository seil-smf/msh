# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowTemplateVariableCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        if command_args[:template_variable_name]
          api = Msh::Api::GETUserUserCodeTemplateIdVariableName.new({
                                                                      :user_code => $conf[:user_code],
                                                                      :id => command_args[:template_id],
                                                                      :name => command_args[:template_variable_name]
                                                                    })
        else
          api = Msh::Api::GETUserUserCodeTemplateIdVariable.new({
                                                                  :user_code => $conf[:user_code],
                                                                  :id => command_args[:template_id]
                                                                })

        end

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          if api.class == Msh::Api::GETUserUserCodeTemplateIdVariable
            res_json = json_load(response.body)["results"]
            $output.puts "---"
            res_json.each_with_index do |template_variable, i|
              $output.puts "- TemplateVariable_#{i}:"
              $output.puts "    TemplateVariable Name: #{template_variable["name"]}"
              $output.puts "    TemplateVariable DefaultValue: #{template_variable["defaultValue"]}"
            end
          else
            template_variable = json_load(response.body)
            $output.puts "---"
            $output.puts "TemplateVariable Name: #{template_variable["name"]}"
            $output.puts "TemplateVariable DefaultValue: #{template_variable["defaultValue"]}"
            $output.puts "Values:"
            template_variable["values"].each_with_index do |value, i|
              $output.puts "  - Value_#{i}:"
              $output.puts "      SA Code: #{value["code"]}"
              $output.puts "      Value: #{value["value"]}"
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
                        :template_id => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('name')
            args.delete_at(idx)
            self[:template_variable_name] = args.delete_at(idx)
          end
        end

      end

    end
  end
end
