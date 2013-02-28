require "msh/api/abstract_api"

module Msh
  module Api
    class PUTUserUserCodeTemplateIdPackCsv < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/template/#{@api_request[:id]}/pack/csv"
        @method = "PUT"
        @content_type = "multipart/form-data"
        @request = { }
      end

    end
  end
end
