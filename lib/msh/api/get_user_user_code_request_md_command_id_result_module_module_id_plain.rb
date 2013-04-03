require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeRequestMdCommandIdResultModuleModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/request/md-command/#{@api_request[:id]}/result/module/#{@api_request[:module_id]}/plain"
        @method = "GET"
      end

    end
  end
end
