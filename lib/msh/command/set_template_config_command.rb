# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'
require 'msh/util/config_edit'

module Msh
  module Command
    class SetTemplateConfigCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::PUTUserUserCodeTemplateIdConfigModuleIdPlain.new({
                                                                           :template_id => command_args[:template_id],
                                                                           :module_id => command_args[:module_id],
                                                                 })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)
        $output.puts "set template-config: TemplateConfig (TemplateSet ID #{command_args[:template_id]}, Module ID #{command_args[:module_id]}) was updated."

#        puts_response(response)
      end

      private

      def read_conf(csv_path)
        File.open(csv_path, 'r'){|f|
          return f.read
        }
      end

      def set_request_param(request_param)
        @request[:request] = { }
        if request_param[:config_path]
          plain_config = read_conf(request_param[:config_path])
        else
          ce = ConfigEdit.new
          ce.doit
          plain_config = ce.get_config
          return if plain_config.nil?
        end
        @request[:request] = plain_config
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command      => args.shift,
                        :subcommand   => args.shift,
                        :template_id  => args.shift,
                        :module_id => args.shift
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('config')
            args.delete_at(idx)
            self[:config_path] = args.delete_at(idx)
          end
        end
      end

    end
  end
end
