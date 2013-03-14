# -*- coding: utf-8 -*-

require 'test_helper'

class PingCommandTest < Test::Unit::TestCase
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

    check_response_json = {
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

    check_response = mock()
    check_response.expects(:code).returns("200")
#    check_response.expects(:content_type).returns("application/json")
    check_response.expects(:body).returns(check_response_json)

    request = {
      :api          => "/user/tsa99999999/request/ping",
      :method       => :POST,
      :content_type => "application/json",
      :request      =>
      {
        :sa            =>
        {
          :code => "tss88888888"
        },
        :targetTime    => nil,
        :targetAddress => "10.0.0.1",
        :size          => 56,
        :count         => 5
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
      "type"             => "ping",
      "targetTime"       => "2012/09/26 14:39:12",
      "status"           => "initial",
      "proxyStatus"      => "none",
      "resultCode"       => "none",
      "targetAddress"    => "10.0.0.1",
      "size"             => 56,
      "count"            => 5,
      "resultSuccess"    => nil,
      "resultFailure"    => nil
    }.to_json


    response = mock()
    response.expects(:code).returns("201")
    response.expects(:body).returns(response_json)

    c = Msh::Command::PingCommand.new
    c.expects(:execute).returns(response)
    c.expects(:execute_poll).returns(check_response)

    c.doit(["ping", "tss88888888", "10.0.0.1"])
    expected_str = "5 packets transmitted, 5 packets received, 0.0% packet loss"

    assert_equal(expected_str, $output.buffer.strip)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end
end
