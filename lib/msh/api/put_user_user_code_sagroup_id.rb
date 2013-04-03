require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeSagroupId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sagroup/#{@api_request[:id]}"
        @method = "PUT"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
