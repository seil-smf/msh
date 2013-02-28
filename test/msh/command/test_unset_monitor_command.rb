# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/unset_monitor_command'
require 'msh/output'

class UnsetMonitorCommandTest < Test::Unit::TestCase
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
      :request      => {
        :reports =>
        [
         { :address => nil},
         { :address => nil},
         { :address => nil},
         { :address => nil},
         { :address => nil}
        ]
      }
    }

    response_json = {
      "id"      => 1,
      "name"    => "MonitorGroup",
      "reports" => [nil, nil, nil, nil, nil],
      "sa"      => []
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::UnsetMonitorCommand.new
    c.expects(:execute).returns(response)

    c.doit(["unset", "monitor", "1", "reports"])

expected_str = <<EOS
---
MonitorGroup ID: 1
MonitorGroup Name: MonitorGroup
  Reports:
    Report_0: 
    Report_1: 
    Report_2: 
    Report_3: 
    Report_4: 
  SA:
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end

