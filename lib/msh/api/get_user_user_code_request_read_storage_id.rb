require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeRequestReadStorageId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/request/read-storage/#{@api_request[:id]}"
        @method = "GET"
      end

    end
  end
end
