require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeRequestReadStatusIdResultModuleModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/request/read-status/#{@api_request[:id]}/result/module/#{@api_request[:module_id]}/plain"
        @method = "GET"
      end

    end
  end
end
