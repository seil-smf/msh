# -*- coding: utf-8 -*-

require 'test_helper'

class ShowModuleCommandTest < Test::Unit::TestCase
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

  def teardown

  end

  def test_no_option
    $output = Msh::Output::Buffer.new

    response_json = {
      "results" => [{
                      "moduleName" => "SEIL/B1 4.10 (Vivace)",
                      "vendorId" => 0,
                      "saType" => 15,
                      "moduleId" => 0,
                      "version" => "4.10.0-0",
                      "binary" => false
                    },
                    {
                      "moduleName" => "SEIL/B1 4.00 (Chorale)",
                      "vendorId" => 0,
                      "saType" => 15,
                      "moduleId" => 0,
                      "version" => "4.0.0-0",
                      "binary" => false
                    },
                   ]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowModuleCommand.new
    c.expects(:execute).returns(response)


expected_str = <<EOS
---
- Module_0:
    Module Name: SEIL/B1 4.10 (Vivace)
    Module ID: 0
    Version: 4.10.0-0
    Binary: false
    SA Type: 15
- Module_1:
    Module Name: SEIL/B1 4.00 (Chorale)
    Module ID: 0
    Version: 4.0.0-0
    Binary: false
    SA Type: 15
EOS


    c.doit(["show", "module"])

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)




  end




end
