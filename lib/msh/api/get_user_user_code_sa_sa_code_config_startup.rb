require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeSaSaCodeConfigStartup < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sa/#{@api_request[:sa_code]}/config/startup"
        @method = "GET"
      end

    end
  end
end
