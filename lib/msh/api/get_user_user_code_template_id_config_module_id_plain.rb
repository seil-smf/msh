require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeTemplateIdConfigModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/template/#{@api_request[:template_id]}/config/#{@api_request[:module_id]}/plain"
        @method = "GET"
      end

    end
  end
end
