require "msh/api/abstract_api"

module Msh
  module Api
    class POSTUserUserCodeRequestReadStorage < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{$conf[:user_code]}/request/read-storage"
        @method = "POST"
        @content_type = "application/json"
        @request = @api_request
#        parse_request unless @request_array.empty?
      end

      def parse_request
        @request = { }

        if ret = parse_single_arg('sa')
          @request[:sa] = {:code => ret}
        end

        @request[:targetTime] = parse_single_arg('targettime')

        if ret = parse_single_arg('storage')
          @request[:storage] = ret
        end

      end

    end
  end
end
