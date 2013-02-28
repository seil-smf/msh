require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeRequestTraceroute < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/request/traceroute"
        @method = "POST"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
