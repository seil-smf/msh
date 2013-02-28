# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class SetTemplateSetCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        if command_args[:csv_path]
          api = Msh::Api::PUTUserUserCodeTemplateIdPackCsv.new({
                                                                 :id => command_args[:template_id]
                                                               })
        else
          api = Msh::Api::PUTUserUserCodeTemplateId.new({
                                                          :id => command_args[:template_id]
                                                        })
        end
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          if api.class == Msh::Api::PUTUserUserCodeTemplateIdPackCsv
            if response.body == "true"
              $output.puts "set template-set: TemplateSet (ID #{command_args[:template_id]}) was updated."
            end
          else
            template_set = json_load(response.body)
            $output.puts "---"
            $output.puts "TemplateSet ID: #{template_set["id"]}"
            $output.puts "TemplateSet Name: #{template_set["name"]}"
            $output.puts "SA: "
            template_set["sa"].each_with_index do |sa, i|
              $output.puts "  SA Code #{i}: #{sa["code"]}"
              $output.puts "  SA Name #{i}: #{sa["name"]}"
            end
          end
        end

      end

      private

      def set_request_param(request_param)
        @request[:request]        = { }
        if request_param[:csv_path]
          @request[:request][:csv_path] = request_param[:csv_path]
        else

          @request[:request][:name] = request_param[:template_name] if request_param[:template_name]
          @request[:request][:sa]   = request_param[:template_sa] if request_param[:template_sa]
        end
      end

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
          if idx = args.index('csv')
            args.delete_at(idx)
            self[:csv_path] = args.delete_at(idx)
          else
            if idx = args.index('name')
              args.delete_at(idx)
              self[:template_name] = args.delete_at(idx)
            end

            if idx = args.index('sa')
              self[:template_sa] = Array.new
              args.delete_at(idx)
              args[idx...args.size].each do |arg|
                self[:template_sa] << {"code" => args.delete_at(idx)}
              end
            end
          end
        end

      end
    end
  end
end
