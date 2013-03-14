# -*- coding: utf-8 -*-

require 'test_helper'

class DeleteTemplateConfigCommandTest < Test::Unit::TestCase
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

    response_text = ""

    response = stub()
    response.stubs(:code).returns("204")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    c = Msh::Command::DeleteTemplateConfigCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["delete", "template-config", "1", "0"])

    expected_str = <<EOS
delete template-config: TemplateConfig (TemplateSet ID 1, Module ID 0) was deleted.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert_equal("204", response.code)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
