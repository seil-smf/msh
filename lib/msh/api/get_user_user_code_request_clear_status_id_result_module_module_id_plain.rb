require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeRequestClearStatusIdResultModuleModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/request/clear-status/#{@api_request[:id]}/result/module/#{@api_request[:module_id]}/plain"
        @method = "GET"
      end

    end
  end
end
