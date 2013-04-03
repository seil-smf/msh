# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ReadStatusCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_optional_args(command_array)
        command_args.parse_args(command_array)
#        return if command_args.has_error?
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeRequestReadStatus.new({
                                                                :user_code => $conf[:user_code],
                                                              })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)
        return if has_targetTime?(command_args, response)
        read_status_id = json_load(response.body)['id']


        api = Msh::Api::GETUserUserCodeRequestReadStatusIdResultModuleModuleIdPlain.new({
                                                                                          :user_code => $conf[:user_code],
                                                                                          :id => read_status_id,
                                                                                          :module_id => command_args[:module_id]
                                                                                        })

        response = execute_poll(api)
        return unless check_http_success(response)
        puts_response(response)

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
          :command => request_param[:status_command]
        }

      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command   => args.shift,
                        :sa => args.shift,
                        :module_id => args.shift,
                        :status_command => args.join(" ")
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

