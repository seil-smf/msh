# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/show_event_command'
require 'msh/output'

class ShowEventCommandTest < Test::Unit::TestCase
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
      :api     => "/user/tsa99999999/event",
      :method  => :GET,
      :request => { }
    }

    response_json = {
      "results" =>
      [{
         "id" => "1:12345",
         "sa" =>
         [{
            "code"           => "tss99999999",
            "name"           => "サービスアダプタ",
            "description"    => "メモ",
            "distributionId" => "0001-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
            "up"             => true,
            "configState"    => "pushready",
            "group"          =>
            {
              "id"   => 1627,
              "name" => "_defaultServiceAdapterGroup"
            },
            "template" => nil,
            "monitor"  => nil
          }],
         "priority"  => "info",
         "type"      => "request",
         "subtype"   => "succeed",
         "timestamp" => "2012/09/27 15:19:26"
       },
       {
         "id" => "1:12344",
         "sa" =>
         [{
            "code"           => "tss99999999",
            "name"           => "サービスアダプタ",
            "description"    => "メモ",
            "distributionId" => "0001-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
            "up"             => true,
            "configState"    => "pushready",
            "group"          =>
            {
              "id"   => 1627,
              "name" => "_defaultServiceAdapterGroup"
            },
            "template" => nil,
            "monitor"  => nil
          }],
         "priority"  => "info",
         "type"      => "request",
         "subtype"   => "sa-run",
         "timestamp" => "2012/09/27 15:19:26"
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowEventCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "event"])

expected_str = <<EOS
---
- Event_0:
    Event ID: 1:12345
    Event Type: request
    Event SubType: succeed
    SA: 
     SA_0 Code: tss99999999
     SA_0 Name: サービスアダプタ
- Event_1:
    Event ID: 1:12344
    Event Type: request
    Event SubType: sa-run
    SA: 
     SA_0 Code: tss99999999
     SA_0 Name: サービスアダプタ
EOS

    assert_equal(expected_str, $output.buffer)


    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
