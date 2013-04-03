# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class UnsetTemplateSetCommand < AbstractCommand
      DEFAULT_TEMPLATESET_NAME = "TemplateSet"

      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::PUTUserUserCodeTemplateId.new({
                                                        :user_code => $conf[:user_code],
                                                        :id => command_args[:id]
                                                      })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
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
        end

      end

      private

      def set_request_param(request_param)
        @request[:request]        = { }
        @request[:request][:name] = request_param[:templateset_name] if request_param[:templateset_name]
        @request[:request][:sa]   = request_param[:templateset_sa] if request_param[:templateset_sa]
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :id => args.shift
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('name')
            args.delete_at(idx)
            self[:templateset_name] = "#{DEFAULT_TEMPLATESET_NAME}"
          end

          if idx = args.index('sa')
            args.delete_at(idx)
            self[:templateset_sa] = Array.new
          end
        end
      end

    end
  end
end
