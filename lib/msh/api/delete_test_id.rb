require "msh/api/abstract_api"

module Msh
  module Api
    class DELETETestId < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/test/#{@api_request[:id]}"
        @method = "DELETE"
      end

    end
  end
end
