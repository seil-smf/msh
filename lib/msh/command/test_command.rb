require 'msh/command/abstract_command'

module Msh
  module Command
    class TestCommand < AbstractCommand
      def doit(command_array)
        @verbose = command_array.delete('-v')

        api = Msh::Api::GETTest.new
        response = execute(api)
        $output.puts "GET Test is #{check_code(response)}"

        api = Msh::Api::POSTTest.new({ })
        api.request = { :message => "post test" }
        response = execute(api)
        $output.puts "POST Test is #{check_code(response)}"

        api = Msh::Api::PUTTestId.new({
                                        :id => 0
                                      })
        api.request = { :message => "put test" }
        response = execute(api)
        $output.puts "PUT Test is #{check_code(response)}"

        api = Msh::Api::DELETETestId.new({
                                           :id => 0
                                         })
        response = execute(api)
        $output.puts "DELETE Test is #{check_code(response)}"

      end

      private

      def check_code(response)
        if response.code =~ /\A20\d\z/
          "Successed."
        else
          "Failed."
        end
      end

    end
  end
end

