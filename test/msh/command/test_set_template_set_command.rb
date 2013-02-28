# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/set_template_set_command'
require 'msh/output'

class SetTemplateSetCommandTest < Test::Unit::TestCase
  def setup
    $conf = {
      :proxy_addr        => "proxy.example.jp",
      :proxy_port        => "8080",
      :domain            => "server.example.jp",
      :path              => "/public-api/v1",
      :access_key        => "xxxxxxxxxxxxxx",
      :access_key_secret => "yyyyyyyyyyyyyyyyy",
      :user_code         => "tsa99999999",
    }
  end

  def test_no_subcommand
    $output = Msh::Output::Buffer.new

    request = {
      :api          => "/user/tsa99999999/template/1",
      :method       => :PUT,
      :content_type => "application/json",
      :request      =>
      {
        :name => 'Template'
      }
    }

    response_json = {
      "id"           => 1,
      "name"         => "Template",
      "moduleId"     => 0,
      "sa"           => [],
      "lastModified" => "2012/11/25 13:06:40",
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::SetTemplateSetCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["templateset", "set", "1", "name", "Template"])

    expected_str = <<EOS
---
TemplateSet ID: 1
TemplateSet Name: Template
SA: 
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
