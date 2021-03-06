# -*- coding: utf-8 -*-

require 'test_helper'

class AddTemplateSetCommandTest < Test::Unit::TestCase
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

  def test_no_option
    $output = Msh::Output::Buffer.new

    response_json = {
      "id"           => 1,
      "name"         => "TemplateSet",
      "moduleId"     => 0,
      "sa"           => [],
      "lastModified" => "2012/11/25 13:06:40",
    }.to_json

    response = mock()
    response.stubs(:code).returns("201")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::AddTemplateSetCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["add", "template-set", "TemplateSet"])

    expected_str = <<EOS
---
TemplateSet ID: 1
TemplateSet Name: TemplateSet
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
