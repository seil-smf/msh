# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowTemplateSetCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        if command_args[:csv] && command_args[:templateset_id]
          api = Msh::Api::GETUserUserCodeTemplateIdPackCsv.new({
                                                                 :user_code => $conf[:user_code],
                                                                 :id => command_args[:templateset_id]
                                                               })
        elsif command_args[:templateset_id]
          api = Msh::Api::GETUserUserCodeTemplateId.new({
                                                          :user_code => $conf[:user_code],
                                                          :id => command_args[:templateset_id]
                                                        })
        else
          api = Msh::Api::GETUserUserCodeTemplate.new({
                                                        :user_code => $conf[:user_code],
                                                      })
        end

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          if command_args[:csv] && command_args[:templateset_id]
            $output.puts response.body
          elsif command_args[:templateset_id]
            template_set = json_load(response.body)
            $output.puts "---"
            $output.puts "TemplateSet ID: #{template_set["id"]}"
            $output.puts "TemplateSet Name: #{template_set["name"]}"
            $output.puts "TemplateSet Member: #{template_set["member"]}"
            $output.puts "SA: "
            template_set["sa"].each_with_index do |sa, i|
              $output.puts "  SA_#{i} Code: #{sa["code"]}"
              $output.puts "  SA_#{i} Name: #{sa["name"]}"
            end
          else
            res_json = json_load(response.body)
            $output.puts "---"
            res_json["results"].each_with_index do |template_set, i|
              $output.puts "- TemplateSet_#{i}:"
              $output.puts "    TemplateSet ID: #{template_set["id"]}"
              $output.puts "    TemplateSet Name: #{template_set["name"]}"
              $output.puts "    TemplateSet Member: #{template_set["member"]}"
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
          if idx = args.index('csv')
            self[:csv] = args.delete_at(idx)
          end

          if idx = args.index('id')
            args.delete_at(idx)
            self[:templateset_id] = args.delete_at(idx)
          end
        end
      end

    end
  end
end
