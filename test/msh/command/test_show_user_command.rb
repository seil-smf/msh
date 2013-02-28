# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/show_user_command'
require 'msh/output'

class ShowUserCommandTest < Test::Unit::TestCase
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
      :api    => "/home",
      :method => :GET,
    }

    response_json ={
      "results" =>
      [{
         "code" => "tsa99999999",
         "name" => "SACM 1"
       },
       {
         "code" => "tsa00000000",
         "name" => "SACM 2"
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowUserCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "user"])

expected_str = <<EOS
---
- User_0:
    Management Code: tsa99999999
    Management Label: SACM 1
- User_1:
    Management Code: tsa00000000
    Management Label: SACM 2
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
