# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowSaGroupCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        if command_args[:sagroup_id]
          api = Msh::Api::GETUserUserCodeSagroupId.new({
                                                         :user_code => $conf[:user_code],
                                                         :id => command_args[:sagroup_id]
                                                       })
        else
          api = Msh::Api::GETUserUserCodeSagroup.new({
                                                       :user_code => $conf[:user_code],
                                                     })
        end

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          if api.class == Msh::Api::GETUserUserCodeSagroup
            res_json = json_load(response.body)["results"]
            $output.puts "---"
            res_json.each_with_index do |sagroup, i|
              $output.puts "- SaGroup_#{i}:"
              $output.puts "    SaGroup ID: #{sagroup["id"]}"
              $output.puts "    SaGroup Name: #{sagroup["name"]}"
              $output.puts "    Member: #{sagroup["member"]}"
            end
          else
            sagroup = json_load(response.body)
            $output.puts "---"
            $output.puts "SaGroup ID: #{sagroup["id"]}"
            $output.puts "SaGroup Name: #{sagroup["name"]}"
            $output.puts "SA:"
            sagroup["sa"].each_with_index do |sa, i|
              $output.puts "  SA_#{i} Code: #{sa["code"]}"
              $output.puts "  SA_#{i} Name: #{sa["name"]}"
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
          self[:sagroup_id] = args.shift unless args.empty?
        end
      end

    end
  end

end
