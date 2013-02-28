require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeRequestPingId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/request/ping/#{@api_request[:id]}"
        @method = "GET"
      end

    end
  end
end
