# -*- coding: utf-8 -*-

require 'test_helper'

class SetSaCommandTest < Test::Unit::TestCase
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
      "code"                => "tss88888888",
      "name"                => "SA",
      "description"         => "",
      "distributionId"      => nil,
      "up"                  => false,
      "configState"         => "initial",
      "group"               => nil,
      "template"            => nil,
      "monitor"             => nil,
      "ipAddress"           => nil,
      "port"                => nil,
      "pulledTrigger"       => "none",
      "pushMethod"          => "none",
      "preferredPushMethod" => nil,
      "date"                =>
      {
        "lastPushReady"       => nil,
        "lastHeartbeatReport" => nil,
        "lastPulled"          => nil,
        "firstPulled"         => nil
      },
      "graph" =>
      {
        "uri"     => "hb400/grapher.cgi",
        "keyCode" => nil
      }
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::SetSaCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["set", "sa", "tss88888888", "name", "SA"])

    expected_str = <<EOS
---
SA Code: tss88888888
SA Label: SA
Description: 
Distribution ID: 
Preferred Push Method: 
Up: false
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
