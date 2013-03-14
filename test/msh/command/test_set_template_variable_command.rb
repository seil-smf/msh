# -*- coding: utf-8 -*-

require 'test_helper'

class SetTemplateVariableCommandTest < Test::Unit::TestCase
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
      "name" => "HOSTNAME",
      "defaultValue" => "hostname",
      "values" => [
                   {
                     "code" => "tsw00000000",
                     "value" => "SA_0",
                   },
                   {
                     "code" => "tss11111111",
                     "value" => "SA_1",
                   }
                  ]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::SetTemplateVariableCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["templateset", "set", "1", "HOSTNAME", "defaultvalue", "hostname", "values", "tsw00000000", "SA_0", "tss11111111", "SA_1"])

    expected_str = <<EOS
---
TemplateVariable Name: HOSTNAME
TemplateVariable DefaultValue: hostname
Values:
  - Value_0:
      SA Code: tsw00000000
      Value: SA_0
  - Value_1:
      SA Code: tss11111111
      Value: SA_1
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
