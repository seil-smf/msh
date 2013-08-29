# encoding: UTF-8

require 'net/https'
require 'openssl'
require 'json'
require 'yaml'
require 'base64'

require 'msh/client/request'

module Msh
  SSL_PORT = 443

  class SacmApiClient
    def initialize(conf, request)
      @conf = conf
      request.set_timezone@conf[:offset_minute] if @conf[:offset_minute]
      request.api = @conf[:path] + request.api
      @request = Msh::Request.build_request(request)
    end

    def start
      req = @request
      req["User-Agent"] = "msh/#{Msh::VERSION} (Ruby/#{RUBY_VERSION})"

      unless @conf[:proxy_addr].nil? || @conf[:proxy_addr].empty?
        https = Net::HTTP::Proxy(@conf[:proxy_addr], @conf[:proxy_port]).new(@conf[:domain], SSL_PORT)
      else
        https = Net::HTTP.new(@conf[:domain], SSL_PORT)
      end

      https.use_ssl = true
      if @conf[:ssl_verify] == "false"
        ssl_verify_mode = OpenSSL::SSL::VERIFY_NONE
      else
        ssl_verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
      https.verify_mode = ssl_verify_mode

      req.basic_auth(@conf[:access_key], @conf[:access_key_secret])

      res = nil
      https.start {|w|
        res = w.request(req)
      }

      return res
    end

  end

end
