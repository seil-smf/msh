require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeSagroupId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sagroup/#{@api_request[:id]}"
        @method = "GET"
      end

    end
  end
end
