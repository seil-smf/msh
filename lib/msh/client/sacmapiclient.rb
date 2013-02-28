# encoding: UTF-8

require 'net/https'
require 'openssl'
require 'json'
require 'yaml'
require 'base64'

module Msh
  SSL_PORT = 443

  class SacmApiClient
    def initialize(conf, request)
      @conf = conf
      @request = build_request(request)
    end
    #initialize

    def start
      req = @request
      req["User-Agent"] = "msh/#{Msh::VERSION} (Ruby/#{RUBY_VERSION})"

      if @conf[:proxy_addr]
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
    #exec_http_request

    private

    def build_request(request)
      case request.method
      when "GET"
        return build_get_request(request)
      when "POST"
        return build_post_request(request)
      when "PUT"
        return build_put_request(request)
      when "DELETE"
        return build_delete_request(request)
      end
    end

    def build_query_string(request)
      if request.nil?
        return ""
      else
        query_array = []
        request.each{|k, v|
          if Integer === v
            v = v.to_s
            query_array.push([k.to_s, v].join('='))
          elsif Array === v
            v.each{|e|
              query_array.push([k.to_s, e].join('='))
            }
          else
            query_array.push([k.to_s, v].join('='))
          end
        }

        return '?' + query_array.join('&')
      end
    end

    def build_get_request(request)
      return  Net::HTTP::Get.new(@conf[:path]+request.api+build_query_string(request.request))
    end
    #build_get_request

    def build_post_request(request)
      req = Net::HTTP::Post.new(@conf[:path]+request.api)

      if request.content_type == 'multipart/form-data'
        build_multipart_form(req, request)
      elsif request.content_type == 'application/json'
        req.content_type = request.content_type
        req.body = request.request.to_json
      end

      return req
    end
    #build_post_request

    def build_put_request(request)
      req = Net::HTTP::Put.new(@conf[:path]+request.api)
      if request.content_type == 'multipart/form-data'
        build_multipart_form(req, request)
      elsif request.content_type == 'application/json'
        req.content_type = request.content_type
        req.body = request.request.to_json
      elsif request.content_type == 'text/plain'
        req.content_type = request.content_type
        req.body = request.request
      end
      return req
    end
    #build_put_request

    def build_delete_request(request)
      return Net::HTTP::Delete.new(@conf[:path]+request.api)
    end
    #build_delete_request

    def build_multipart_form(req, request)
      form = MultipartFormData.new(build_boundary(64))

      form.set_content_type(request.content_type)

      request.request.each{|k, v|

        if k == :"moduleId/type_command"
          v.each do |module_command|
            form.set_boundary
            form.set_crlf

            form.set_form_data('Content-Disposition: form-data; name="' + module_command[:"moduleId/type"] + '"')
            form.set_crlf

            form.set_form_data(module_command[:command])
          end

        elsif k == :config_path
          form.set_boundary
          form.set_crlf

          form.set_form_data('Content-Disposition: form-data; name="binary-config-file"; filename="' + v + '"')
          form.set_form_data('Content-Type: application/octet-stream')
          form.set_crlf

          File.open(request_obj[:request][:config_path], "rb"){|f|
            form.set_form_data(f.read)
          }
          form.set_crlf

        elsif k == :csv_path
          form.set_boundary
          form.set_crlf

          form.set_form_data('Content-Disposition: form-data; name="variable-csv-file"; filename="' + File.basename(v) + '"')
          form.set_form_data('Content-Type: text/csv')
          form.set_crlf

          File.open(request.request[:csv_path], "r"){|f|
            form.set_form_data(f.read)
          }
          form.set_crlf
        elsif
          form.set_boundary
          form.set_crlf

          form.set_form_data('Content-Disposition: form-data; name="' + k.to_s + '"')
          form.set_crlf
          v = "" if v.nil?
          form.set_form_data(v)
        else
          next
        end

      }
      form.set_boundary
      form.set_str("--")

      req.content_type = form[:content_type]
      req.body = form[:body]

    end
    #build_multipart_form

    def build_boundary(n)
      boundary = ''
      n.times{
        boundary += (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a)[Random.rand(62)]
      }
      return boundary
    end
    #build_boundary

    class MultipartFormData < Hash
      CRLF = "\r\n"
      def initialize(boundary)
        @boundary = boundary
        self[:body] = ""
        self[:content_type] = ""
      end

      def set_boundary
        self[:body] << "--" + @boundary
      end

      def set_content_type(content_type)
         self[:content_type] << content_type + "; boundary=" + @boundary
      end

      def set_form_data(form_data)
        self[:body] << form_data + CRLF
      end

      def set_crlf
        self[:body] << CRLF
      end

      def set_str(str)
        self[:body] << str
      end

    end

  end
end
