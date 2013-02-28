require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeSaSaCodeConfigWorkingBlank < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/sa/#{@api_request[:sa]}/config/working/blank"
        @method = "PUT"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
