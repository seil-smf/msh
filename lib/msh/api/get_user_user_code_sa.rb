require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeSa < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/sa"
        @method = "GET"
      end
    end
  end
end
