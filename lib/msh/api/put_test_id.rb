require "msh/api/abstract_api"

module Msh
  module Api
    class PUTTestId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/test/#{@api_request[:id]}"
        @method = "PUT"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
