# -*- coding: utf-8 -*-

require 'test_helper'

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

  def test_no_option
    $output = Msh::Output::Buffer.new

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

  def test_no_sa_reports_option
    $output = Msh::Output::Buffer.new

    response_json = {
      "id"      => 1,
      "name"    => "GroupMonitor",
      "reports" => [{"address" => "sample@sacm.jp"}, nil, nil, nil, nil],
      "sa"      => [{"code" => "tsw00000000", "name" => "SA_Name"}]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::SetMonitorCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["set", "monitor", "1", "name", "GroupMonitor", "sa", "tsw00000000", "reports", "sample@sacm.jp"])

    expected_str = <<EOS
---
MonitorGroup ID: 1
MonitorGroup Name: GroupMonitor
Reports:
  report 0: sample@sacm.jp
  report 1: 
  report 2: 
  report 3: 
  report 4: 
SA:
  SA Code 0: tsw00000000
  SA Name 0: SA_Name
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
