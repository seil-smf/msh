# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class DeleteSaGroupCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')
        command_args = CommandArgs.new
        command_args.parse_args(command_array)
        return if command_args.has_error?
        command_args.parse_optional_args(command_array)

        api = Msh::Api::DELETEUserUserCodeSagroupId.new({
                                                          :user_code => $conf[:user_code],
                                                          :id => command_args[:sagroup_id]
                                                        })

        response = execute(api)
        return unless check_http_success(response)

        $output.puts "delete sagroup: SaGroup (ID: #{command_args[:sagroup_id]}) was deleted."

#        puts_response(response)
      end

      private

      class CommandArgs < Hash
        include Msh::AbstractCommandArgs

        def parse_args(args)
          self.merge!({
                        :command    => args.shift,
                        :subcommand => args.shift,
                        :sagroup_id => args.shift,
                      })
        end

        def parse_optional_args(args)
          # nothing to do.
        end

      end

    end
  end
end
