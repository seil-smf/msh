module Msh
  module Request
    def self.build_request(request)
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

    def self.build_query_string(request, question)
      if request.nil?
        return ""
      else
        query_array = []
        request.each do |k, v|
          case v
          when Integer
            v = v.to_s
            query_array.push([k.to_s, v].join('='))
          when Array
            v.each do |e|
              query_array.push([k.to_s, e].join('='))
            end
          else
            query_array.push([k.to_s, v].join('='))
          end
        end

        return "#{question ? nil : "?"}#{query_array.join('&')}"
      end
    end

    def self.build_get_request(request)
      Net::HTTP::Get.new(request.api+build_query_string(request.request, request.api.index("?")))
    end

    def self.build_post_request(request)
      req = Net::HTTP::Post.new(request.api)

      case request.content_type
      when 'multipart/form-data'
        build_multipart_form(req, request)
      when 'application/json'
        req.content_type = request.content_type
        req.body = request.request.to_json
      end

      req
    end

    def self.build_put_request(request)
      req = Net::HTTP::Put.new(request.api)

      case request.content_type
      when 'multipart/form-data'
        build_multipart_form(req, request)
      when 'application/json'
        req.content_type = request.content_type
        req.body = request.request.to_json
      when 'text/plain'
        req.content_type = request.content_type
        req.body = request.request
      end

      req
    end

    def self.build_delete_request(request)
      Net::HTTP::Delete.new(request.api)
    end

    def self.build_multipart_form(req, request)
      form = MultipartFormData.new

      form.set_content_type(request.content_type)

      request.request.each do |k, v|
        case k
        when :"moduleId/type_command"
          v.each do |module_command|
            form.set_boundary
            form.set_crlf

            form.set_form_data('Content-Disposition: form-data; name="' + module_command[:"moduleId/type"] + '"')
            form.set_crlf

            form.set_form_data(module_command[:command])
          end

        when :config_path
          form.set_boundary
          form.set_crlf

          form.set_form_data('Content-Disposition: form-data; name="binary-config-file"; filename="' + v + '"')
          form.set_form_data('Content-Type: application/octet-stream')
          form.set_crlf

          File.open(request_obj[:request][:config_path], "rb") do |f|
            form.set_form_data(f.read)
          end
          form.set_crlf

        when :csv_path
          form.set_boundary
          form.set_crlf

          form.set_form_data('Content-Disposition: form-data; name="variable-csv-file"; filename="' + File.basename(v) + '"')
          form.set_form_data('Content-Type: text/csv')
          form.set_crlf

          File.open(request.request[:csv_path], "r") do |f|
            form.set_form_data(f.read)
          end
          form.set_crlf
        when k
          form.set_boundary
          form.set_crlf

          form.set_form_data('Content-Disposition: form-data; name="' + k.to_s + '"')
          form.set_crlf
          v = "" if v.nil?
          form.set_form_data(v)
        else
          next
        end

      end
      form.set_boundary
      form.set_str("--")

      req.content_type = form[:content_type]
      req.body = form[:body]
    end


    class MultipartFormData < Hash
      CRLF = "\r\n"
      BOUNDARY_CHAR = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a

      def initialize
        @boundary = build_boundary(64)
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

      private

      def build_boundary(n)
        boundary = ''
        n.times do
          boundary << BOUNDARY_CHAR[Random.rand(62)]
        end
        return boundary
      end
    end

  end
end
