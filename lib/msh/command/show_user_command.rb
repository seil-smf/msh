# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowUserCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?

        api = Msh::Api::GETHome.new

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          res_json = json_load(response.body)["results"]
          $output.puts "---"
          res_json.each_with_index do |user, i|
            $output.puts "- User_#{i}:"
            $output.puts "    Management Code: #{user["code"]}"
            $output.puts "    Management Label: #{user["name"]}"
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

