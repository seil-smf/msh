require 'json'
require 'msh/api'
require 'msh/client/sacmapiclient'

module Msh
  class Cache
    attr_accessor :sa_code, :sagroup_id, :monitor_id, :template_set_id, :template_variable_name

    def initialize
      @sa_code = load_id(Msh::Api::GETUserUserCodeSa.new({ }), "code")
      @sagroup_id = load_id(Msh::Api::GETUserUserCodeSagroup.new({ }), "id")
      @monitor_id = load_id(Msh::Api::GETUserUserCodeMonitor.new({ }), "id")
      @template_set_id = load_id(Msh::Api::GETUserUserCodeTemplate.new({ }), "id")
      @template_variable_name = {}
      @template_set_id.each do |template_id|
        @template_variable_name[template_id] = load_id(Msh::Api::GETUserUserCodeTemplateIdVariable.new({
                                                       :id => template_id
                                                     }),
                "name")
      end

    end

    def load_id(api, key)
      ret = []
      begin
        sacmapiclient = SacmApiClient.new($conf, api)
        response = sacmapiclient.start
        json_res = JSON.load(response.body)
        if json_res["results"]
          iter = json_res["results"]
        else
          iter = json_res
        end
        iter.each do |obj|
          ret << obj[key].to_s unless obj[key].nil?
        end
      rescue => e
        p e
      end
      ret
    end
  end
end

