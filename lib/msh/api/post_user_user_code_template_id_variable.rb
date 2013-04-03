require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeTemplateIdVariable < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/template/#{@api_request[:id]}/variable"
        @method = "POST"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
