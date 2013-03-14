# -*- coding: utf-8 -*-

require 'test_helper'

class AbstractCommandTest < Test::Unit::TestCase
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

    @abstract_command = Msh::AbstractCommand.new
  end

  def teardown
    $conf = nil
    @abstract_command = nil
  end

  def test_check_http_success
    $output = Msh::Output::Buffer.new

    response = mock()
    response.stubs(:code).returns("404")
    response.stubs(:message).returns("Not Found")

    @abstract_command.send(:check_http_success, response)

    expected_str = "API response status code is 404 (Not Found).\n"

    assert_kind_of(String, $output.buffer)
    assert_equal(expected_str, $output.buffer)
  end

  def test_check_request_response
    $output = Msh::Output::Buffer.new

    response_json = {
      "status" => "successed"
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:message).returns("HTTP OK")
    response.stubs(:body).returns(response_json)

    response.stubs(:content_type).returns("application/json")
    assert(@abstract_command.send(:check_request_response, response))

    response.stubs(:content_type).returns("text/plain")
    assert(@abstract_command.send(:check_request_response, response))

    response.stubs(:content_type).returns("application/octet-stream")
    assert(@abstract_command.send(:check_request_response, response))

    response.stubs(:content_type).returns("text/csv")
    assert(@abstract_command.send(:check_request_response, response))
  end

  def test_puts_response
    $output = Msh::Output::Buffer.new

    response_json = {
      "status" => "successed"
    }.to_json

    response_text = "HTTP OK"
    response_text_no_content = "Success."

    response_csv = "HTTP, OK"

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:message).returns("HTTP OK")

    response.stubs(:body).returns(response_json)
    response.stubs(:content_type).returns("application/json")
    assert_equal("---\nstatus: successed\n\n", @abstract_command.send(:puts_response, response))
    $output.clear

    response.stubs(:body).returns(response_csv)
    response.stubs(:content_type).returns("text/csv")
    assert_equal("HTTP, OK\n", @abstract_command.send(:puts_response, response))
    $output.clear

    response.stubs(:body).returns(response_text)
    response.stubs(:content_type).returns("text/plain")
    assert_equal("HTTP OK\n", @abstract_command.send(:puts_response, response))
    $output.clear

    response.stubs(:body).returns(response_text_no_content)
    response.stubs(:code).returns("204")
    response.stubs(:message).returns("NO CONTENT")
    assert_equal("Success.\n", @abstract_command.send(:puts_response, response))
  end

  def test_module_init

    client = mock()
    client.expects(:start).returns()

    Msh::SacmApiClient.expects(:new).returns(client)

    request = {
      :sa => "tsw00000000"
    }

    @abstract_command.send(:module_init, request)
  end


  def test_get_vendor_code_sa_type
    response_json = {
      "distributionId" => "0000-1111-2222-3333-4444-5555-6666-7777"
    }.to_json

    response = mock()
    response.expects(:body).returns(response_json)

    request = {
      :sa => "tsw00000000"
    }

    client = mock()
    client.expects(:start).returns(response)

    Msh::SacmApiClient.expects(:new).returns(client)

    ret = @abstract_command.send(:get_vendor_code_sa_type, request)

    assert_kind_of(Hash, ret)

    distid = JSON.load(response_json)['distributionId'].gsub(/-/, "")
    assert_equal(distid[4, 8].to_i(16), ret[:vendor])
    assert_equal(distid[12, 4].to_i(16), ret[:satype])
  end

  def test_module_exist?
    vendor_sa = {
      :vendor => 0,
      :satype => 15
    }

    response_json = {
      "results" => [
                    {
                    "moduleId" => 0
                    },
                    {
                    "moduleId" => 1
                    },
                    {
                    "moduleId" => 2
                    },
                   ]
    }.to_json

    response = mock()
    response.expects(:body).returns(response_json)

    request = {
      :sa => "tsw00000000"
    }

    @abstract_command.expects(:get_vendor_code_sa_type).returns(vendor_sa)

    client = mock()
    client.expects(:start).returns(response)

    Msh::SacmApiClient.expects(:new).returns(client)

    assert(@abstract_command.send(:module_exist?, request))
  end

  def test_need_module_init
    response = mock()
    response.expects(:code).returns("404")

    request = {
      :sa => "tsw00000000"
    }

    @abstract_command.expects(:module_exist?).returns(true)
    @abstract_command.expects(:execute).returns(response)

    assert(@abstract_command.send(:need_module_init?, request))
  end

  def test_get_module_type
    response_json = {
      "results" => [
                    {
                      "binary" => false,
                      "moduleId" => 0
                    }
                   ]
    }.to_json

    response = mock()
    response.expects(:body).returns(response_json)

    request = {
      :sa => "tsw00000000",
      :module_id => "0"
    }

    @abstract_command.expects(:need_module_init?).returns(true)
    @abstract_command.expects(:module_init)
    @abstract_command.expects(:execute).returns(response)
    ret = @abstract_command.send(:get_module_type, request)
    assert_kind_of(String, ret)
    assert_equal("plain", ret)
  end

  def test_execute
    $output = Msh::Output::Buffer.new
    assert(Msh::SacmApiClient)

    client = mock()
    client.expects(:start).returns()

    Msh::SacmApiClient.expects(:new).returns(client)

    @abstract_command.send(:execute, "request")
  end

#  def test_execute_poll
#    $output = Msh::Output::Buffer.new
#
#    response_json = {
#      "status" => "successed"
#    }.to_json
#
#    response = mock()
#    response.stubs(:code).returns("200")
#    response.stubs(:message).returns("HTTP OK")
#    response.stubs(:body).returns(response_json)
#    response.stubs(:content_type).returns("application/json")
#
#    client = mock()
#    client.expects(:start).returns(response)
#
#    Msh::SacmApiClient.expects(:new).returns(client)
#
#    @abstract_command.send(:execute_poll, "request")
#  end

end
