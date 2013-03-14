require 'test_helper'

class ShowTemplateConfigCommandTest < Test::Unit::TestCase
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

expected_str = <<EOS
interface.ge0.ipv4.address: dhcp
interface.ge1.ipv4.address: ${ GE1ADDRESS}/${ GE1PREFIX}
route.ipv4.0.destination: default
route.ipv4.0.gateway: dhcp
interface.pppoe0.id: sacm@example.jp
interface.pppoe0.password: sacm
interface.pppoe0.ipcp: enable
resolver.service: enable
resolver.1.address: dhcp
resolver.domain: example.jp
dns-forwarder.service: enable
dns-forwarder.1.address: ipcp
dns-forwarder.2.address: 192.168.1.100
dns-forwarder.listen.ipv4.100.interface: pppoe0
EOS

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(expected_str)

    c = Msh::Command::ShowTemplateConfigCommand.new
    c.expects(:execute).returns(response)


    c.doit(["show", "template-config", "1", "0"])


    assert_equal(expected_str, $output.buffer.chomp)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
