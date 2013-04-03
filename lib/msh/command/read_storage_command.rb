# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class ReadStorageCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)
        set_request_param(command_args)

        api = Msh::Api::POSTUserUserCodeRequestReadStorage.new({
                                                                 :user_code => $conf[:user_code],
                                                               })
        api.request = @request[:request]

        response = execute(api)
        return unless check_http_success(response)
        return if has_targetTime?(command_args, response)

        read_storage_id = json_load(response.body)['id']
        api = Msh::Api::GETUserUserCodeRequestReadStorageIdResultModuleModuleIdPlain.new({
                                                                                           :user_code => $conf[:user_code],
                                                                                           :id => read_storage_id,
                                                                                           :module_id => 0
                                                                                         })

        response = execute_poll(api)
        return unless check_http_success(response)
        puts_response(response)
      end

      private

      def set_request_param(request_param)
        @request[:request] = {
          :sa         => {
            :code => request_param[:sa]
          },
          :targetTime => request_param[:targetTime],
          :storage    => request_param[:storage]
        }
      end

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
            :command => args.shift,
            :sa => args.shift,
            :storage => args.shift,
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
