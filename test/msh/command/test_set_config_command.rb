# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/set_config_command'
require 'msh/output'

class SetConfigCommandTest < Test::Unit::TestCase
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

  def test_working
    $output = Msh::Output::Buffer.new

    request = {
      :api          => "/user/tsa99999999/sa/tss88888888/config/working/0/plain",
      :method       => :PUT,
      :content_type => "text/plain",
      :request      => "hostname \"seil\"\ninterface lan1 add dhcp\nroute add default dhcp\n"
    }

    response_text = nil

    response = mock()
    response.stubs(:code).returns("204")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    c = Msh::Command::SetConfigCommand.new
    c.stubs(:get_module_type).returns("plain")
    c.stubs(:read_conf).returns("hostname \"seil\"\ninterface lan1 add dhcp\nroute add default dhcp\n")
    c.stubs(:execute).returns(response)

    c.doit(["config", "set", "tss88888888", "working", "module", "0", "config", "/tmp/plain_config"])

    expected_str = <<EOS
set config: Working Config was updated.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert_equal("204", response.code)
  end

  def test_running
    $output = Msh::Output::Buffer.new

    request = {
      :api          => "/user/tsa99999999/sa/tss88888888/config/running",
      :method       => :PUT,
      :content_type => "application/json",
      :request      =>
      {
        :deployStartup => true,
        :date          => nil
      }
    }

    response_text = nil

    response = mock()
    response.stubs(:code).returns("204")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    c = Msh::Command::SetConfigCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["set", "config", "tss88888888", "running"])

    expected_str = <<EOS
set config: Running Config was updated.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert_equal("204", response.code)
  end

  def test_startup
    $output = Msh::Output::Buffer.new

    request = {
      :api          => "/user/tsa99999999/sa/tss88888888/config/startup",
      :method       => :PUT,
      :content_type => "application/json",
    }

    response_text = nil

    response = mock()
    response.stubs(:code).returns("204")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    c = Msh::Command::SetConfigCommand.new
    c.expects(:execute).returns(response)

    c.doit(["set", "config", "tss88888888", "startup"])

    expected_str = <<EOS
set config: Startup Config was updated.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert_equal("204", response.code)
  end

end
