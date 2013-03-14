# -*- coding: utf-8 -*-

require 'test_helper'

class ReadStatusCommandTest < Test::Unit::TestCase
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

    check_response_text = "SEIL/X1 IPL Monitor version 1.03\nSEIL/X1 Ver. 4.00 (OutsidersEdge)\n\nArch    : SEIL/X1 Rev. A\nCPU     : CN30XX (0xd0202) Rev. 2\nVendor  : OEM\nSerial  : AD9010J-BAAXXXXXXXXX\n\nHost    : \"seil\"\nBootinfo: rebooting by software reset\nBootdev : flash\n\nDate    : 2001/01/18 09:07:19 (JST)\nUp      : 36 minutes  (since 2001/01/18 08:31:44)\n\nUsers   : 0 users\nLoadavg : 0.00 (1min), 0.01 (5min), 0.00 (15min)\nCPUstat : Used 0%, Interrupts 0%\nMemory  : Total 128MB, Used 100MB (78%), Avail 28MB (21%)"

    check_response = stub()
    check_response.stubs(:code).returns("200")
    check_response.stubs(:content_type).returns("text/plain")
    check_response.stubs(:body).returns(check_response_text)

    response_json = {
      "id"                  => "1:12345",
      "sa"                  =>
      {
        "code"              => "tss88888888",
        "name"              => "サービスアダプタ",
        "description"       => "メモ",
        "distributionId"    => "0000-0000-0000-0000-FFFF-FFFF-FFFF-FFFF",
        "up"                => true
      },
      "type"                => "read-status",
      "targetTime"          => "2012/09/26 14:39:12",
      "status"              => "initial",
      "proxyStatus"         => "none",
      "resultCode"          => "none",
      "requestModuleMdData" =>
      {
        "id"                => 0,
        "result"            => nil,
        "binary"            => false
      },
      "resultModuleMdData"  => nil
    }.to_json

    response = stub()
    response.stubs(:code).returns("201")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ReadStatusCommand.new
    c.stubs(:get_module_type).returns('plain')
    c.stubs(:execute).returns(response)
    c.stubs(:execute_poll).returns(check_response)

    c.doit(["read-status", "tss88888888", "0", "show system"])

    expected_str = <<EOS
SEIL/X1 IPL Monitor version 1.03\nSEIL/X1 Ver. 4.00 (OutsidersEdge)\n\nArch    : SEIL/X1 Rev. A
CPU     : CN30XX (0xd0202) Rev. 2
Vendor  : OEM
Serial  : AD9010J-BAAXXXXXXXXX

Host    : \"seil\"
Bootinfo: rebooting by software reset\nBootdev : flash

Date    : 2001/01/18 09:07:19 (JST)
Up      : 36 minutes  (since 2001/01/18 08:31:44)

Users   : 0 users
Loadavg : 0.00 (1min), 0.01 (5min), 0.00 (15min)
CPUstat : Used 0%, Interrupts 0%
Memory  : Total 128MB, Used 100MB (78%), Avail 28MB (21%)
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
