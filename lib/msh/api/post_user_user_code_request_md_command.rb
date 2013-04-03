require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeRequestMdCommand < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/request/md-command"
        @method = "POST"
        @content_type = "multipart/form-data"
        @request = { }
      end

    end
  end
end
