# -*- coding: utf-8 -*-

require 'test_helper'

class AddMonitorCommandTest < Test::Unit::TestCase
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
      "id"      => 1,
      "name"    => "MonitorGroup",
      "reports" => [nil, nil, nil, nil, nil],
      "sa"      => []
    }.to_json

    response = mock()
    response.stubs(:code).returns("201")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::AddMonitorCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["add", "monitor", "MonitorGroup"])

    expected_str = <<EOS
---
MonitorGroup ID: 1
MonitorGroup Name: MonitorGroup
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
