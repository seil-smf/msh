require "msh/api/abstract_api"

module Msh
  module Api
    class POSTTest < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/test"
        @method = "POST"
        @content_type = "application/json"
        @request = { }
      end

    end
  end
end
