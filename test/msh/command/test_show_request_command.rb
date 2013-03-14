# -*- coding: utf-8 -*-

require 'test_helper'

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
    c.stubs(:execute).returns(response)

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

  def test_with_option
    $output = Msh::Output::Buffer.new

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
      "type"             => "ping",
      "targetTime"       => "2012/09/26 14:52:29",
      "status"           => "successed",
      "proxyStatus"      => "success",
      "resultCode"       => "success",
      "targetAddress"    => "10.0.0.1",
      "size"             => 56,
      "count"            => 5,
      "resultSuccess"    => 5,
      "resultFailure"    => 0
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowRequestCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["show", "request", "type", "ping", "id", "1:12345"])

expected_str = <<EOS
---
- Request_0:
    Request ID: 1:12345
    Request Type: ping
    SA Code: tss88888888
    SA Name: サービスアダプタ
    Status: successed
    Target Time: 2012/09/26 14:52:29
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
