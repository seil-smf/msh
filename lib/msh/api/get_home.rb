# -*- coding: utf-8 -*-

require "msh/api/abstract_api"

module Msh
  module Api
    class GETHome < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/home"
        @method = "GET"
      end

    end
  end
end

