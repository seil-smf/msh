# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/clear_status_command'
require 'msh/output'

class ClearStatusCommandTest < Test::Unit::TestCase
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
      :api    => '/user/tsa99999999/request/clear-status/1:12345/result/module/0/plain',
      :method => :GET
    }

    check_response_text = "0 entries flushed from NAT table"

    check_response = stub()
    check_response.stubs(:code).returns("200")
    check_response.stubs(:content_type).returns("text/plain")
    check_response.stubs(:body).returns(check_response_text)

    request = {
      :api          => "/user/tsa99999999/request/clear-status",
      :method       => :POST,
      :content_type => "multipart/form-data",
      :request      =>
      {
        :code            => "tss88888888",
        :targetTime      => nil,
        :"moduleId/type_command" => [{
                                       :"moduleId/type" => "0/plain",
                                       :command         => "show system",
                                     }]
      }
    }

    response_json = {
      "id"                  => "1:12345",
      "sa"                  =>
      {
        "code"              => "tss88888888",
        "name"              => "サービスアダプタ",
        "description"       => "メモ",
        "distributionId"    => "0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
        "up"                => true
      },
      "type"                => "clear-status",
      "targetTime"          => "2012/09/26 14:39:12",
      "status"              => "initial",
      "proxyStatus"         => "none",
      "resultCode"          => "none",
      "requestModuleMdData" =>
      {
        "id"                => 0,
        "result"            => nil,
        "binary"            => false
      },
      "resultModuleMdData"  => nil
    }.to_json

    response = stub()
    response.stubs(:code).returns("201")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ClearStatusCommand.new
    c.stubs(:get_module_type).returns('plain')
    c.stubs(:execute).returns(response)
    c.stubs(:execute_poll).returns(check_response)

    c.doit(["clear-status", "tss88888888", "0", "clear nat-session ipv4"])

expected_str = <<EOS
0 entries flushed from NAT table
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end
end
