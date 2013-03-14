# -*- coding: utf-8 -*-

require 'test_helper'

class DeteleTemplateVariableCommandTest < Test::Unit::TestCase
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

    response_str = ""

    response = mock()
    response.stubs(:code).returns("204")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_str)

    c = Msh::Command::DeleteTemplateVariableCommand.new
    c.expects(:execute).returns(response)

    c.doit(["delete", "template-variable", "1", "HOSTNAME"])

expected_str = <<EOS
template-variable: TemplateVariable (TemplateSet ID 1, TemplateVariable Name HOSTNAME) was deleted.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
