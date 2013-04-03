# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowSaCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        if command_args[:sa]
          api = Msh::Api::GETUserUserCodeSaSaCode.new({
                                                        :user_code => $conf[:user_code],
                                                        :sa => command_args[:sa]
                                                      })
        else
          api = Msh::Api::GETUserUserCodeSa.new({
                                                  :user_code => $conf[:user_code],
                                                })
        end

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          if api.class == Msh::Api::GETUserUserCodeSa
            res_json = json_load(response.body)["results"]
            $output.puts "---"
            res_json.each_with_index do |sa, i|
              $output.puts "- SA_#{i}:"
              $output.puts "    SA Code: #{sa["code"]}"
              $output.puts "    SA Label: #{sa["name"]}"
              $output.puts "    Description: #{sa["description"]}"
              $output.puts "    Distribution ID: #{sa["distributionId"]}"
              $output.puts "    Preferred Push Method: #{sa["preferredPushMethod"]}"
              $output.puts "    Up: #{sa["up"]}"
            end
          else
            sa = json_load(response.body)
            $output.puts "---"
            $output.puts "SA Code: #{sa["code"]}"
            $output.puts "SA Label: #{sa["name"]}"
            $output.puts "Description: #{sa["description"]}"
            $output.puts "Distribution ID: #{sa["distributionId"]}"
            $output.puts "Preferred Push Method: #{sa["preferredPushMethod"]}"
            $output.puts "Up: #{sa["up"]}"
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
          self[:sa] = args.shift unless args.empty?
        end
      end

    end
  end
end
