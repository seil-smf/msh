require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeSaSaCodeConfigWorkingModuleId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/sa/#{@api_request[:sa]}/config/working/#{@api_request[:id]}"
        @method = "PUT"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
