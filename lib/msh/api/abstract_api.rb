# -*- coding: utf-8 -*-

module Msh
  module Api
    class AbstractApi
      attr_accessor :api, :request, :method, :content_type

      def initialize(request = nil)
        @errors = nil
        unless $conf
          require 'msh/conf'
          $conf = Msh::Conf.new.read
        end

        @api_request = request
        set_param
        validate

      end

      def validate
        self.private_methods.map{|sym| sym.to_s}.grep(/\Avalidate_.+\z/).each do |validate_method|
          eval validate_method
        end

        if @errors
          @errors.each do |error|
            puts error
          end
        end

      end

      def parse_single_arg(attr)
        if idx = @api_request.index(attr)
          @api_request.delete_at(idx)
          @api_request.delete_at(idx)
        end
      end

      def parse_multiple_args(attr)

      end

    end
  end
end
