# -*- coding: utf-8 -*-

require "msh/api/abstract_api"

module Msh
  module Api
    class GETHomeModule < Msh::Api::AbstractApi
      private

      def set_param
        @api = "/home/module"
        @method = "GET"
        @request = { }
      end

    end
  end
end
