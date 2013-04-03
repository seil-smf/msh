# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class MdCommandCommand < AbstractCommand
      def post_md_command_task
        api = Msh::Api::POSTUserUserCodeRequestMdCommand.new({
                                                               :user_code => $conf[:user_code],
                                                             })
        api.request = @request[:request]

        execute(api)
      end

      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        command_args.parse_optional_args(command_array)
        return if command_args.has_error?
        set_request_param(command_args)

        response = post_md_command_task
        return unless check_http_success(response)
        return if has_targetTime?(command_args, response)
        md_command_id = json_load(response.body)['id']

        api = Msh::Api::GETUserUserCodeRequestMdCommandId.new({
                                                                :user_code => $conf[:user_code],
                                                                :id => md_command_id,
                                                              })
        response = execute_poll(api)
        return unless check_http_success(response)

        md_command = json_load(response.body)
          if md_command["status"] == "successed"
            api = Msh::Api::GETUserUserCodeRequestMdCommandIdResultModuleModuleIdPlain.new({
                                                                                             :user_code => $conf[:user_code],
                                                                                             :id => md_command_id,
                                                                                             :module_id => command_args[:module_id]
                                                                                           })

            response = execute(api)
            return unless check_http_success(response)
            puts_response(response)
          else
            $output.puts "md_command: failed."
          end

      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :code            => request_param[:sa],
          :targetTime      => request_param[:targetTime],
        }

        @request[:request][:"moduleId/type_command"] = []
        @request[:request][:"moduleId/type_command"] << {
          :"moduleId/type" => "#{request_param[:module_id]}/plain",
          :command => request_param[:md_command]
        }

      end

      class CommandArgs < Hash
        def has_error?
          if self[:module_id] !~ /^\d+$/
            $output.puts 'md-command: specified Module ID is invalid.'
            return true
          end

          if self[:md_command].empty?
            $output.puts 'md-command: parameter invalid.'
            return true
          end
        end

        def parse_args(args)
          self.merge!({
                        :command   => args.shift,
                        :sa => args.shift,
                        :module_id => args.shift,
                        :md_command => args.join(" ")
                      })
        end

        def parse_optional_args(args)
          if idx = args.index('targettime')
            args.delete_at(idx)
            self[:targetTime] = [args.delete_at(idx), args.delete_at(idx)].join(' ')
          end

          self[:targetTime] ||= Msh::Constants::REQUEST_TARGET_TIME
        end
      end

    end
  end
end

