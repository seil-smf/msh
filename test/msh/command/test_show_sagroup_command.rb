# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/show_sagroup_command'
require 'msh/output'

class ShowSaGroupCommandTest < Test::Unit::TestCase
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
      :api    => "/user/tsa99999999/sagroup",
      :method => :GET,
    }

    response_json = {
      "results" =>
      [{
         "id"     => nil,
         "name"   => nil,
         "member" => 3
       },
       {
         "id"     => 3,
         "name"   => "SA Group",
         "member" => 1
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowSaGroupCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "sagroup"])

expected_str = <<EOS
---
- SaGroup_0:
    SaGroup ID: 
    SaGroup Name: 
    Member: 3
- SaGroup_1:
    SaGroup ID: 3
    SaGroup Name: SA Group
    Member: 1
EOS

    assert_equal(expected_str, $output.buffer)


    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_with_id
    $output = Msh::Output::Buffer.new

    request = {
      :api    => "/user/tsa99999999/sagroup/3",
      :method => :GET,
    }

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
           "name" => "sagroup",
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

    c = Msh::Command::ShowSaGroupCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "sagroup", "3"])

expected_str = <<EOS
---
SaGroup ID: 3
SaGroup Name: SA Group
SA:
  SA_0 Code: tss88888888
  SA_0 Name: サービスアダプタ
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
