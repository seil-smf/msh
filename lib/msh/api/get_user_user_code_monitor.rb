require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeMonitor < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/monitor"
        @method = "GET"
      end

    end
  end
end
