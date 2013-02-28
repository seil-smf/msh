# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ShowConfigCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        if command_args.has_type_error?
          $output.puts 'show config: specified config type is invalid.'
          return
        end

        if command_args[:module_id]
          config_type = command_args[:type].split(/[\/|_|-]/).map{|token| token.capitalize}.join
          candidate_api = eval "Msh::Api::GETUserUserCodeSaSaCodeConfig#{config_type}ModuleIdPlain"
          api = candidate_api.new({
                                    :sa_code => command_args[:sa],
                                    :module_id => command_args[:module_id]
                                  })

        elsif command_args[:type]
          config_type = command_args[:type].split(/[\/|_|-]/).map{|token| token.capitalize}.join
          candidate_api = eval "Msh::Api::GETUserUserCodeSaSaCodeConfig#{config_type}"
          api = candidate_api.new({
                                    :sa_code => command_args[:sa]
                                  })
        else
            api = Msh::Api::GETUserUserCodeSaSaCodeConfig.new({
                                                                :sa_code => command_args[:sa]
                                                              })

        end

        response = execute(api)
        return unless check_http_success(response)

        if @verbose
          puts_response(response)
        else
          if command_args[:module_id]
            puts_response(response)
          elsif command_args[:type]
            res_json = json_load(response.body)
            $output.puts "---"
            $output.puts "#{command_args[:type].capitalize} Config:"
            res_json["results"].each do |config_entry|
              $output.puts " - Module ID: #{config_entry["moduleId"]}"
              $output.puts "   Module Name: #{config_entry["moduleName"]}"
              $output.puts "   Version: #{config_entry["version"]}"
              $output.puts "   Binary: #{config_entry["binary"]}"
            end
          else
            res_json = json_load(response.body)
            $output.puts "---"
            %w(working startup running).each do |type|
              $output.puts "- #{type.capitalize} Config:"
              res_json[type]["results"].each do |config_entry|
                $output.puts "    - Module ID: #{config_entry["moduleId"]}"
                $output.puts "      Module Name: #{config_entry["moduleName"]}"
                $output.puts "      Version: #{config_entry["version"]}"
                $output.puts "      Binary: #{config_entry["binary"]}"
              end
            end
          end
        end
      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :sa         => {
            :code => request_param[:sa]
          },
          :targetTime => request_param[:targetTime],
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def has_type_error?
          ret = nil
          if self[:type]
            valid_config_type = [
                                 'working',
                                 'running',
                                 'startup',
                                 'preview',
                                ]
            ret = !valid_config_type.include?(self[:type])
          end
          ret
        end

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :sa => args.shift,
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('type')
            self[:type] = args[idx + 1]
          end

          if idx = args.index('module')
            self[:module_id] = args[idx + 1]
          end
        end
      end

    end
  end
end
