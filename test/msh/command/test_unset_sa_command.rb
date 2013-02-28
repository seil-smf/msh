# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/unset_sa_command'
require 'msh/output'

class UnsetSaCommandTest < Test::Unit::TestCase
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
      :api          => "/user/tsa99999999/sa/tss88888888",
      :method       => :PUT,
      :content_type => "application/json",
      :request      =>
      {
        :name => "tss88888888"
      }
    }

    response_json = {
      "code"                => "tss88888888",
      "name"                => "tss88888888",
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

    c = Msh::Command::UnsetSaCommand.new
    c.expects(:execute).returns(response)

    c.doit(["sa", "unset", "tss88888888", "name"])

    expected_str = <<EOS
---
SA Code: tss88888888
SA Label: tss88888888
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

