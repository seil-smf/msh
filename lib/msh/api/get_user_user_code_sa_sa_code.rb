require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeSaSaCode < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sa/#{@api_request[:sa]}"
        @method = "GET"
      end
    end
  end
end
