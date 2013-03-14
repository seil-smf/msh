# -*- coding: utf-8 -*-

require 'test_helper'

class SetSaGroupCommandTest < Test::Unit::TestCase
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

    response_json = {
      "sa" =>
      [{
         "code"           => "tss88888888",
         "name"           => "サービスアダプタ",
         "description"    => "メモ",
         "distributionId" => "0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
         "up"             => true,
         "configState"    => "pushready",
         "group" => {
           "id"   => 3,
           "name" => "SA Group",
         },
         "template" => nil,
         "monitor"  => nil
       }],
      "id"   => 3,
      "name" => "SA Group"
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::SetSaGroupCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["set", "sagroup", "3", "name", "SA Group", "sa", "tss88888888"])

    expected_str = <<EOS
---
SaGroup ID: 3
SaGroup Name: SA Group
 SA:
  SA Code 0: tss88888888
  SA Name 0: サービスアダプタ
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
