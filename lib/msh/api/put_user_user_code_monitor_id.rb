require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeMonitorId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/monitor/#{@api_request[:id]}"
        @method = "PUT"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
