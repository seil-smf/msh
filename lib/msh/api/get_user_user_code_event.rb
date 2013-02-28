require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeEvent < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/event"
        @method = "GET"
        @request = { }
      end

    end
  end
end
