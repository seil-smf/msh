require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeTemplate < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/template"
        @method = "POST"
        @content_type = "application/json"
      end

    end
  end
end
