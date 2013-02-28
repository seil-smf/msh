require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeSaSaCodeConfigWorkingModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/sa/#{@api_request[:sa_code]}/config/working/#{@api_request[:module_id]}/plain"
        @method = "GET"
      end

    end
  end
end
