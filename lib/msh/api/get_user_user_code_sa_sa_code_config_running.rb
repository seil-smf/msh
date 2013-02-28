require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeSaSaCodeConfigRunning < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/sa/#{@api_request[:sa_code]}/config/running"
        @method = "GET"
      end

    end
  end
end
