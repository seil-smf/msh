# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/set_template_config_command'
require 'msh/output'

class SetTemplateConfigCommandTest < Test::Unit::TestCase
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
      :api          => "/user/tsa99999999/template/1/config/0/plain",
      :method       => :PUT,
      :content_type => "text/plain",
      :request      => "template_config"
    }

    response_text = ""

    response = mock()
    response.stubs(:code).returns("204")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    c = Msh::Command::SetTemplateConfigCommand.new
    c.expects(:execute).returns(response)
    c.expects(:read_conf).returns("template_config")

    config_path = File.join(File.dirname(File.expand_path(__FILE__)), "template.conf")
    c.doit(["set", "template-config", "1", "0", "config", config_path])

    expected_str = <<EOS
set template-config: TemplateConfig (TemplateSet ID 1, Module ID 0) was updated.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

 
end
