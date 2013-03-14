# -*- coding: utf-8 -*-

require 'test_helper'

class ShowMonitorCommandTest < Test::Unit::TestCase
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
      :api    => "/user/tsa99999999/monitor",
      :method => :GET,
    }

    response_json = {"results" =>
      [{
         "id"     => nil,
         "name"   => nil,
         "member" => 5
       },
       {
         "id"     => 1,
         "name"   => "Monitor Group1",
         "member" => 0
       },
       {
         "id"     => 3,
         "name"   => "Monitor Group2",
         "member" => 0
       },
       {
         "id"     => 5,
         "name"   => "Monitor Group3",
         "member" => 0
       },
       {
         "id"     => 7,
         "name"   => "Monitor Group4",
         "member" => 0
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowMonitorCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "monitor"])

expected_str = <<EOS
---
- Monitor_0:
    MonitorGroup ID: 
    MonitorGroup Name: 
    Member: 5
- Monitor_1:
    MonitorGroup ID: 1
    MonitorGroup Name: Monitor Group1
    Member: 0
- Monitor_2:
    MonitorGroup ID: 3
    MonitorGroup Name: Monitor Group2
    Member: 0
- Monitor_3:
    MonitorGroup ID: 5
    MonitorGroup Name: Monitor Group3
    Member: 0
- Monitor_4:
    MonitorGroup ID: 7
    MonitorGroup Name: Monitor Group4
    Member: 0
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_with_monitor_id
    $output = Msh::Output::Buffer.new

    response_json = {
      "id"     => 1,
      "name"   => "Monitor Group1",
      "reports" => [
                     nil,
                     nil,
                     nil,
                     nil,
                     nil,
                     ],
      "sa" => []
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowMonitorCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "monitor", "1"])

expected_str = <<EOS
---
MonitorGroup ID: 1
MonitorGroup Name: Monitor Group1
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
