require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeSagroup < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sagroup"
        @method = "GET"
      end

    end
  end
end
