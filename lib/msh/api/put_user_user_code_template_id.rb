require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeTemplateId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/template/#{@api_request[:id]}"
        @method = "PUT"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
