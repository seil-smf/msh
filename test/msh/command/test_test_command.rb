# -*- coding: utf-8 -*-

require 'test_helper'

class TestCommandTest < Test::Unit::TestCase
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

    response = mock()
    response.stubs(:code).returns("200")

    c = Msh::Command::TestCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["test"])

    expected_str = <<EOS
GET Test is Successed.
POST Test is Successed.
PUT Test is Successed.
DELETE Test is Successed.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
