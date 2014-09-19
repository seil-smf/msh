require 'json'
require 'msh/api'
require 'msh/client/sacmapiclient'

module Msh
  class Cache
    attr_accessor :sa_code, :sagroup_id, :monitor_id, :template_set_id, :template_variable_name

    def initialize
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

    def reload
      @sa_code = load_id(Msh::Api::GETUserUserCodeSa.new({:user_code => $conf[:user_code], }), "code")
      @sagroup_id = load_id(Msh::Api::GETUserUserCodeSagroup.new({:user_code => $conf[:user_code], }), "id")
      @monitor_id = load_id(Msh::Api::GETUserUserCodeMonitor.new({:user_code => $conf[:user_code], }), "id")
      @template_set_id = load_id(Msh::Api::GETUserUserCodeTemplate.new({:user_code => $conf[:user_code], }), "id")
      @template_variable_name = {}
      @template_set_id.each do |template_id|
        @template_variable_name[template_id] = load_id(Msh::Api::GETUserUserCodeTemplateIdVariable.new({
                                                                                                         :user_code => $conf[:user_code],
                                                                                                         :id => template_id
                                                                                                       }),
                                                       "name")
      end
    end

  end
end

