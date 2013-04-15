# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'
require 'msh/util/config_edit'

module Msh
  module Command
    class SetConfigCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        return if command_args.has_module_error?
        set_request_param(command_args)

        case command_args[:config_class]
        when 'working'
          config_type = get_module_type(command_args)

          api = Msh::Api::PUTUserUserCodeSaSaCodeConfigWorkingModuleIdPlain.new({
                                                                                  :user_code => $conf[:user_code],
                                                                                  :sa => command_args[:sa],
                                                                                  :module_id => command_args[:module_id]
                                                                                })
          api.request = @request[:request]
        when 'running'
          api = Msh::Api::PUTUserUserCodeSaSaCodeConfigRunning.new({
                                                                     :user_code => $conf[:user_code],
                                                                     :sa => command_args[:sa],
                                                                   })

          @request[:request] = { }
          @request[:request][:deployStartup] = true
          @request[:request][:date] = nil
          api.request = @request[:request]

        when 'startup'
          api = Msh::Api::PUTUserUserCodeSaSaCodeConfigStartup.new({
                                                                     :user_code => $conf[:user_code],
                                                                     :sa => command_args[:sa],
                                                                   })

        end

        response = execute(api)

        if response.code == "400"
          $output.puts "set config: #{command_args[:config_class].capitalize} Config is invalid."
          json_load(response.body)['results'].each do |error|
            $output.puts "Line #{error['row']}: #{error['error']}: \"#{error['line']}\""
          end
        elsif response.code =~ HTTP_SUCCESS
          $output.puts "set config: #{command_args[:config_class].capitalize} Config was updated."
        else
          check_http_success(response)
        end
#        puts_response(response)
      end

      private

      def read_conf(config_path)
        File.open(config_path, 'r'){|f|
          return f.read
        }
      end

      def set_request_param(request_param)
        case request_param[:config_class]
        when 'working'
          if request_param[:config_path]
            plain_config = read_conf(request_param[:config_path])
          else
            ce = ConfigEdit.new
            ce.doit
            plain_config = ce.get_config
            return if plain_config.nil?
          end

          @request[:request] = plain_config

        when 'running'
        when 'startup'
        else
          # nothing to do
        end
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def has_module_error?
          if self[:config_class] == "working" && self[:module_id].nil?
            $output.puts "set config: parameter invalied."
            return true
          end
        end

        def parse_args(args)
          self.merge!({
                        :command      => args.shift,
                        :subcommand   => args.shift,
                        :sa => args.shift,
                        :config_class => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('module')
            args.delete_at(idx)
            self[:module_id] = args.delete_at(idx)
          end

          if idx = args.index('config')
            args.delete_at(idx)
            self[:config_path] = args.delete_at(idx)
          end
        end
      end

    end
  end
end
