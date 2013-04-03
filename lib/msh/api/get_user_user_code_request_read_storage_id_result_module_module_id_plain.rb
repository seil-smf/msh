require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeRequestReadStorageIdResultModuleModuleIdPlain < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/request/read-storage/#{@api_request[:id]}/result/module/#{@api_request[:module_id]}/plain"
        @method = "GET"
      end

    end
  end
end
