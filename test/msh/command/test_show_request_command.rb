# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/show_request_command'
require 'msh/output'

class ShowRequestCommandTest < Test::Unit::TestCase
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
      :api     => "/user/tsa99999999/request",
      :method  => :GET,
      :request => { }
    }

    response_json = {
      "results" =>
      [{
         "id" => "1:12345",
         "sa" =>
         {
           "code"           => "tss88888888",
           "name"           => "サービスアダプタ",
           "description"    => "メモ",
           "distributionId" => "0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
           "up"             => true
         },
         "type"        => "ping",
         "targetTime"  => "2012/09/30 23:50:00",
         "status"      => "initial",
         "proxyStatus" => "none",
         "resultCode"  => "none"
       },
       {
         "id" => "1:12344",
         "sa" =>
         {
           "code"           => "tss88888888",
           "name"           => "サービスアダプタ",
           "description"    => "メモ",
           "distributionId" => "0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
           "up"             => true
         },
         "type"        => "ping",
         "targetTime"  => "2012/09/30 23:50:00",
         "status"      => "initial",
         "proxyStatus" => "none",
         "resultCode"  => "none"
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowRequestCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "request"])

expected_str = <<EOS
---
- Request_0:
    Request ID: 1:12345
    Request Type: ping
    SA Code: tss88888888
    SA Name: サービスアダプタ
    Status: initial
    Target Time: 2012/09/30 23:50:00
- Request_1:
    Request ID: 1:12344
    Request Type: ping
    SA Code: tss88888888
    SA Name: サービスアダプタ
    Status: initial
    Target Time: 2012/09/30 23:50:00
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
