# -*- coding: utf-8 -*-

require 'test_helper'

class ShowTemplateSetCommandTest < Test::Unit::TestCase
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
      "results" =>
      [{
         "id"           => nil,
         "name"         => nil,
         "member"       => 0,
         "moduleId"     => [],
         "lastModified" => nil,
       },
       {
         "id"           => 1,
         "name"         => "Template1",
         "member"       => 0,
         "moduleId"     => [
                            0,
                            1
                           ],
         "lastModified" => "2012/11/25 13:06:40",
       }
      ]
    }.to_json

    response = stub()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowTemplateSetCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "template"])

expected_str = <<EOS
---
- TemplateSet_0:
    TemplateSet ID: 
    TemplateSet Name: 
    TemplateSet Member: 0
- TemplateSet_1:
    TemplateSet ID: 1
    TemplateSet Name: Template1
    TemplateSet Member: 0
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert_equal("200", response.code)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_with_option
    $output = Msh::Output::Buffer.new

    response_json = {
      "id" => 1,
      "name" => "Template1",
      "moduleId" => [
                     0,
                     1
                    ],
      "sa" => [],
    }.to_json

    response = stub()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowTemplateSetCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "template-set", "id", "1"])

expected_str = <<EOS
---
TemplateSet ID: 1
TemplateSet Name: Template1
TemplateSet Member: 
SA: 
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert_equal("200", response.code)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_with_csv_option
    $output = Msh::Output::Buffer.new

    response_csv = <<EOS
[name],HOSTNAME
[default],hostname
EOS

    response = stub()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("text/csv")
    response.stubs(:body).returns(response_csv)

    c = Msh::Command::ShowTemplateSetCommand.new
    c.expects(:execute).returns(response)

    c.doit(["show", "template-set", "id", "1", "csv"])

expected_str = <<EOS
[name],HOSTNAME
[default],hostname

EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert_equal("200", response.code)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
