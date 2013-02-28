require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeSaSaCodeConfigWorkingModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/sa/#{@api_request[:sa]}/config/working/#{@api_request[:module_id]}/plain"
        @method = "PUT"
        @content_type = "text/plain"
        @request = { }
      end

    end
  end
end
