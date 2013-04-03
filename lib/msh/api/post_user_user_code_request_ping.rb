require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeRequestPing < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/request/ping"
        @method = "POST"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
