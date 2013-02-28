# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/set_monitor_command'
require 'msh/output'

class SetMonitorCommandTest < Test::Unit::TestCase
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
      :api          => "/user/tsa99999999/monitor/1",
      :method       => :PUT,
      :content_type => "application/json",
      :request      =>
      {
        :name => "GroupMonitor"
      }
    }

    response_json = {
      "id"      => 1,
      "name"    => "GroupMonitor",
      "reports" => [nil, nil, nil, nil, nil],
      "sa"      => []
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::SetMonitorCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["set", "monitor", "1", "name", "GroupMonitor"])

    expected_str = <<EOS
---
MonitorGroup ID: 1
MonitorGroup Name: GroupMonitor
Reports:
  report 0: 
  report 1: 
  report 2: 
  report 3: 
  report 4: 
SA:
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
