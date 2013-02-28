# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/reboot_command'
require 'msh/output'

class RebootCommandTest < Test::Unit::TestCase
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
      :api          => "/user/tsa99999999/request/reboot",
      :method       => :POST,
      :content_type => "application/json",
      :request      =>
      {
        :sa =>
        {
          :code => "tss88888888"
        },
        :targetTime => nil
      }
    }

    response_json = {
      "id"               => "1:12345",
      "sa"               =>
      {
        "code"           => "tss88888888",
        "name"           => "サービスアダプタ",
        "description"    => "メモ",
        "distributionId" => "0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
        "up"             => true
      },
      "type"             => "reboot",
      "targetTime"       => "2012/09/26 14:52:29",
      "status"           => "initial",
      "proxyStatus"      => "none",
      "resultCode"       => "none"
    }.to_json

    response = mock()
    response.stubs(:code).returns("201")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::RebootCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["reboot", "tss88888888"])

    expected_str = <<EOS
reboot: task was registered.
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end
end
