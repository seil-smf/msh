# -*- coding: utf-8 -*-

require 'test_helper'

class ShowTemplateVariableCommandTest < Test::Unit::TestCase
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
      "results" => [{
                      "name" => "HOSTNAME",
                      "defaultValue" => "hostname"
                    },
                    {
                      "name" => "LAN0ADDRESS",
                      "defaultValue" => "192.168.0.1"
                    },
                    {
                      "name" => "LAN0PREFIX",
                      "defaultValue" => "24"
                    },
                    {
                      "name" => "LAN1ADDRESS",
                      "defaultValue" => "172.0.0.1"
                    },
                    {
                      "name" => "LAN1PREFIX",
                      "defaultValue" => "24"

                    },]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowTemplateVariableCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "template-variable", "1"])

expected_str = <<EOS
---
- TemplateVariable_0:
    TemplateVariable Name: HOSTNAME
    TemplateVariable DefaultValue: hostname
- TemplateVariable_1:
    TemplateVariable Name: LAN0ADDRESS
    TemplateVariable DefaultValue: 192.168.0.1
- TemplateVariable_2:
    TemplateVariable Name: LAN0PREFIX
    TemplateVariable DefaultValue: 24
- TemplateVariable_3:
    TemplateVariable Name: LAN1ADDRESS
    TemplateVariable DefaultValue: 172.0.0.1
- TemplateVariable_4:
    TemplateVariable Name: LAN1PREFIX
    TemplateVariable DefaultValue: 24
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_with_option
    $output = Msh::Output::Buffer.new

    response_json = {
      "name" => "HOSTNAME",
      "defaultValue" => "hostname",
      "values" => [],
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowTemplateVariableCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "template-variable", "1", "name", "HOSTNAME"])

expected_str = <<EOS
---
TemplateVariable Name: HOSTNAME
TemplateVariable DefaultValue: hostname
Values:
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
