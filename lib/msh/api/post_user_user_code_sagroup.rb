require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeSagroup < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/sagroup"
        @method = "POST"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
