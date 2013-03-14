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


end
