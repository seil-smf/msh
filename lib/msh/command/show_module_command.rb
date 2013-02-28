# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowModuleCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?

        api = Msh::Api::GETHomeModule.new({ })

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          res_json = json_load(response.body)["results"]
          $output.puts "---"
          res_json.each_with_index do |mod, i|
            $output.puts "- Module_#{i}:"
            $output.puts "    Module Name: #{mod["moduleName"]}"
            $output.puts "    Module ID: #{mod["moduleId"]}"
            $output.puts "    Version: #{mod["version"]}"
            $output.puts "    Binary: #{mod["binary"]}"
            $output.puts "    SA Type: #{mod["saType"]}"
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

      end

    end
  end
end
