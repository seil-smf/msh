require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeTemplateIdConfigModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/template/#{@api_request[:template_id]}/config/#{@api_request[:module_id]}/plain"
        @method = "PUT"
        @content_type = "text/plain"
        @request = { }
      end

    end
  end
end
