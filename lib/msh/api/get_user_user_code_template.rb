require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeTemplate < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/template"
        @method = "GET"
      end

    end
  end
end
