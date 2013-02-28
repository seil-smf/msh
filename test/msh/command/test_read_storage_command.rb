# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/read_storage_command'
require 'msh/output'

class ReadStorageCommandTest < Test::Unit::TestCase
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
      :api    => '/user/tsa99999999/request/read-storage/1:12345/result/module/0/plain',
      :method => :GET
    }

    check_response_text = "hostname \"seil\"\ninterface lan1 add dhcp\nroute add default dhcp"

    check_response = stub()
    check_response.stubs(:code).returns("200")
    check_response.stubs(:content_type).returns("text/plain")
    check_response.stubs(:body).returns(check_response_text)

    request = {
      :api          => "/user/tsa99999999/request/read-storage",
      :method       => :POST,
      :content_type => "application/json",
      :request      =>
      {
        :sa =>
        {
          :code => "tss88888888"
        },
        :targetTime => nil,
        :storage    => "running"
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
      "type"             => "read-storage",
      "targetTime"       => "2012/09/26 14:39:12",
      "status"           => "initial",
      "proxyStatus"      => "none",
      "resultCode"       => "none",
      "storage"          => "running",
      "moduleMdData"     => nil
    }.to_json

    response = stub()
    response.stubs(:code).returns("201")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ReadStorageCommand.new
    c.stubs(:execute).returns(response)
    c.stubs(:execute_poll).returns(check_response)

    c.doit(["read-storage", "tss88888888", "running"])

    expected_str = <<EOS
hostname "seil"
interface lan1 add dhcp
route add default dhcp
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end
end
