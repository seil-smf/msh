require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeRequestReadStorage < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/request/read-storage"
        @method = "POST"
        @content_type = "application/json"
        @request = @api_request
      end

    end
  end
end
