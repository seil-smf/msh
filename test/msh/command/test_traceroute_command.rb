# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/traceroute_command'
require 'msh/output'

class TracerouteCommandTest < Test::Unit::TestCase
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

    check_request = {
      :api    => '/user/tsa99999999/request/traceroute/1:12345',
      :method => :GET
    }

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
      "type"             => "traceroute",
      "targetTime"       => "2012/09/26 14:52:29",
      "status"           => "successed",
      "proxyStatus"      => "success",
      "resultCode"       => "success",
      "targetAddress"    => "10.0.0.1",
      "maxHop"           => 30,
      "count"            => 3,
      "resultNodeInfo"   =>
      [{
         "hop"           => 1,
         "address"       => "10.0.0.1"
       }]
    }.to_json

    check_response = mock()
    check_response.stubs(:code).returns("200")
    check_response.stubs(:content_type).returns("application/json")
    check_response.stubs(:body).returns(check_response_json)

    request = {
      :api          => "/user/tsa99999999/request/traceroute",
      :method       => :POST,
      :content_type => "application/json",
      :request      =>
      {
        :sa =>
        {
          :code => "tss88888888"
        },
        :targetTime    => nil,
        :targetAddress => "10.0.0.1",
        :maxHop        => 30,
        :count         => 3
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
      "type"             => "traceroute",
      "targetTime"       => "2012/09/26 14:39:12",
      "status"           => "initial",
      "proxyStatus"      => "none",
      "resultCode"       => "none",
      "targetAddress"    => "10.0.0.1",
      "maxHop"           => 30,
      "count"            => 3,
      "resultNodeInfo"   => nil
    }.to_json

    response = mock()
    response.stubs(:code).returns("201")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::TracerouteCommand.new
    c.stubs(:execute).returns(response)
    c.stubs(:execute_poll).returns(check_response)

    c.doit(["traceroute", "tss88888888", "10.0.0.1"])

expected_str = <<EOS
traceroute to 10.0.0.1, 30 hops max, 3 packets
 1 10.0.0.1
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end
end
