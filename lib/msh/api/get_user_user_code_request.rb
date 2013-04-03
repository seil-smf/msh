# -*- coding: utf-8 -*-

require "msh/api/abstract_api"

module Msh
  module Api
    class GETUserUserCodeRequest < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/user/#{@api_request[:user_code]}/request"
        @method = "GET"
        @request = { }
      end

    end
  end
end
