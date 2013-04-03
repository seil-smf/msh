require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeSaSaCodeConfigStartup < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sa/#{@api_request[:sa]}/config/startup"
        @method = "PUT"
        @request = { }
      end

    end
  end
end
