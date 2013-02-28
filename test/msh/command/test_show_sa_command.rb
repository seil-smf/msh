# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/show_sa_command'
require 'msh/output'

class ShowSaCommandTest < Test::Unit::TestCase
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
      :api    => "/user/tsa99999999/sa",
      :method => :GET,
    }

    response_json = {
      "results" =>
      [{
         "code"           => "tss88888888",
         "name"           => "サービスアダプタ",
         "description"    => "メモ",
         "distributionId" => "0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
         "up"             => true,
         "configState"    => "pushready",
         "group"          => nil,
         "template"       => nil,
         "monitor"        => nil
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowSaCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "sa"])

expected_str = <<EOS
---
- SA_0:
    SA Code: tss88888888
    SA Label: サービスアダプタ
    Description: メモ
    Distribution ID: 0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF
    Preferred Push Method: 
    Up: true
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
