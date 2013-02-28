require "msh/api/abstract_api"

module Msh
  module Api
    class GETTest < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/test"
        @method = "GET"
      end

    end
  end
end
