require "msh/api/abstract_api"

module Msh
  module Api
    class DELETEUserUserCodeSagroupId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sagroup/#{@api_request[:id]}"
        @method = "DELETE"
      end

    end
  end
end
