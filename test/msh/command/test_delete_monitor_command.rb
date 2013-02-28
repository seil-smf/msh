# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/delete_monitor_command'
require 'msh/output'

class DeleteMonitorCommandTest < Test::Unit::TestCase
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
      :api    => "/user/tsa99999999/monitor/1",
      :method => :DELETE,
    }

    response_text = nil

    response = stub()
    response.stubs(:code).returns("204")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    c = Msh::Command::DeleteMonitorCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["delete", "monitor", "1"])

    expected_str = <<EOS
delete monitor: MonitorGroup (ID: 1) is deleted.
EOS

    assert_equal(expected_str, $output.buffer)


    assert_kind_of(String, $output.buffer)
    assert_equal("204", response.code)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
