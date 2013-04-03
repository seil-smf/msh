require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeSaSaCodeConfigRunning < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sa/#{@api_request[:sa]}/config/running"
        @method = "PUT"
        @content_type = "application/json"
      end

    end
  end
end
