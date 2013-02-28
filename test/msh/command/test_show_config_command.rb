# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/show_config_command'
require 'msh/output'

class ShowConfigCommandTest < Test::Unit::TestCase
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
      :api    => "/user/tsa99999999/sa/tss88888888/config",
      :method => :GET
    }

    response_json = {
      "working" =>
      {
        "results" =>
        [{
           "moduleId"     => 0,
           "moduleName"   => "SEIL/X 4.00 (OutsidersEdge)",
           "version"      => "4.0.0-0",
           "binary"       => false,
           "lastModified" => "2012/09/26 17:09:00"
         },
         {
           "moduleId"     => 1,
           "moduleName"   => "update-firmware",
           "version"      => "0.0.0-0",
           "binary"       => false,
           "lastModified" => "2012/09/10 11:15:47"
         }]
      },
      "startup" =>
      {
        "results" =>
        [{
           "moduleId"     => 0,
           "moduleName"   => "SEIL/X 4.00 (OutsidersEdge)",
           "version"      => "4.0.0-0",
           "binary"       => false,
           "lastModified" => "2012/09/25 14:18:16"
         },
         {
           "moduleId"     => 1,
           "moduleName"   => "update-firmware",
           "version"      => "0.0.0-0",
           "binary"       => false,
           "lastModified" => "2012/09/10 11:15:47"
         }]
      },
      "running" =>
      {
        "results" =>
        [{
           "moduleId"     => 0,
           "moduleName"   => "SEIL/X 4.00 (OutsidersEdge)",
           "version"      => "4.0.0-0",
           "binary"       => false,
           "lastModified" => "2012/09/25 14:18:16"
         },
         {
           "moduleId"     => 1,
           "moduleName"   => "update-firmware",
           "version"      => "0.0.0-0",
           "binary"       => false,
           "lastModified" => "2012/09/10 11:15:47"
         }]
      }
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowConfigCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["show", "config", "tss88888888"])

expected_str = <<EOS
---
- Working Config:
    - Module ID: 0
      Module Name: SEIL/X 4.00 (OutsidersEdge)
      Version: 4.0.0-0
      Binary: false
    - Module ID: 1
      Module Name: update-firmware
      Version: 0.0.0-0
      Binary: false
- Startup Config:
    - Module ID: 0
      Module Name: SEIL/X 4.00 (OutsidersEdge)
      Version: 4.0.0-0
      Binary: false
    - Module ID: 1
      Module Name: update-firmware
      Version: 0.0.0-0
      Binary: false
- Running Config:
    - Module ID: 0
      Module Name: SEIL/X 4.00 (OutsidersEdge)
      Version: 4.0.0-0
      Binary: false
    - Module ID: 1
      Module Name: update-firmware
      Version: 0.0.0-0
      Binary: false
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_working
    $output = Msh::Output::Buffer.new

    request = {
      :api    => "/user/tsa99999999/sa/tss88888888/config/working",
      :method => :GET
    }

    response_json = {
      "results" =>
      [{
         "moduleId"     => 0,
         "moduleName"   => "SEIL/X 4.00 (OutsidersEdge)",
         "version"      => "4.0.0-0",
         "binary"       => false,
         "lastModified" => "2012/09/26 17:09:00"
       },
       {
         "moduleId"     => 1,
         "moduleName"   => "update-firmware",
         "version"      => "0.0.0-0",
         "binary"       => false,
         "lastModified" => "2012/09/10 11:15:47"
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowConfigCommand.new
    c.stubs(:execute).returns(response)
    c.doit(["show", "config", "tss88888888", "type", "working"])

    expected_str = <<EOS
---
Working Config:
 - Module ID: 0
   Module Name: SEIL/X 4.00 (OutsidersEdge)
   Version: 4.0.0-0
   Binary: false
 - Module ID: 1
   Module Name: update-firmware
   Version: 0.0.0-0
   Binary: false
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_working_with_moduleid
    $output = Msh::Output::Buffer.new

    request = {
      :api    => "/user/tsa99999999/sa/tss88888888/config/working/0/plain",
      :method => :GET
    }

    response_text = "hostname \"seil\"\ninterface lan1 add dhcp\nroute add default dhcp"

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    get_module_type_args = {
      :command    => "show",
      :subcommand => "config",
      :sa         => "tss88888888",
      :type       => "working",
      :module_id  => '0',
    }

    c = Msh::Command::ShowConfigCommand.new
    c.stubs(:get_module_type).returns('plain')
    c.stubs(:execute).returns(response)

    c.doit(["show", "config", "tss88888888", "type", "working", "module", "0"])

    expected_str = <<EOS
hostname "seil"
interface lan1 add dhcp
route add default dhcp
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_startup
    $output = Msh::Output::Buffer.new

    request = {
      :api    => "/user/tsa99999999/sa/tss88888888/config/startup",
      :method => :GET
    }

    response_json = {
      "results" =>
      [{
         "moduleId"     => 0,
         "moduleName"   => "SEIL/X 4.00 (OutsidersEdge)",
         "version"      => "4.0.0-0",
         "binary"       => false,
         "lastModified" => "2012/09/25 14:18:16"
       },
       {
         "moduleId"     => 1,
         "moduleName"   => "update-firmware",
         "version"      => "0.0.0-0",
         "binary"       => false,
         "lastModified" => "2012/09/10 11:15:47"
       }]
    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowConfigCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["show", "config", "tss88888888", "type", "startup"])

    expected_str = <<EOS
---
Startup Config:
 - Module ID: 0
   Module Name: SEIL/X 4.00 (OutsidersEdge)
   Version: 4.0.0-0
   Binary: false
 - Module ID: 1
   Module Name: update-firmware
   Version: 0.0.0-0
   Binary: false
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_startup_with_moduleid
    $output = Msh::Output::Buffer.new

    request = {
      :api    => "/user/tsa99999999/sa/tss88888888/config/startup/0/plain",
      :method => :GET
    }

    response_text = "hostname \"seil\"\ninterface lan1 add dhcp\nroute add default dhcp"

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    get_module_type_args = {
      :command    => "show",
      :subcommand => "config",
      :sa         => "tss88888888",
      :type       => "startup",
      :module_id  => '0',
    }

    c = Msh::Command::ShowConfigCommand.new
    c.stubs(:get_module_type).returns('plain')
    c.stubs(:execute).returns(response)

    c.doit(["show", "config", "tss88888888", "type", "startup", "module", "0"])

    expected_str = <<EOS
hostname "seil"
interface lan1 add dhcp
route add default dhcp
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_running
    $output = Msh::Output::Buffer.new

    request = {
      :api    => "/user/tsa99999999/sa/tss88888888/config/running",
      :method => :GET
    }

    response_json = {
      "results" =>
      [{
         "moduleId"     => 0,
         "moduleName"   => "SEIL/X 4.00 (OutsidersEdge)",
         "version"      => "4.0.0-0",
         "binary"       => false,
         "lastModified" => "2012/09/25 14:18:16"
       },
       {
         "moduleId"     => 1,
         "moduleName"   => "update-firmware",
         "version"      => "0.0.0-0",
         "binary"       => false,
         "lastModified" => "2012/09/10 11:15:47"
       }]

    }.to_json

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("application/json")
    response.stubs(:body).returns(response_json)

    c = Msh::Command::ShowConfigCommand.new
    c.stubs(:execute).returns(response)

    c.doit(["show", "config", "tss88888888", "type", "running"])

    expected_str = <<EOS
---
Running Config:
 - Module ID: 0
   Module Name: SEIL/X 4.00 (OutsidersEdge)
   Version: 4.0.0-0
   Binary: false
 - Module ID: 1
   Module Name: update-firmware
   Version: 0.0.0-0
   Binary: false
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_running_with_moduleid
    $output = Msh::Output::Buffer.new

    request = {
      :api    => "/user/tsa99999999/sa/tss88888888/config/running/0/plain",
      :method => :GET
    }

    response_text = "hostname \"seil\"\ninterface lan1 add dhcp\nroute add default dhcp"

    response = mock()
    response.stubs(:code).returns("200")
    response.stubs(:content_type).returns("text/plain")
    response.stubs(:body).returns(response_text)

    get_module_type_args = {
      :command    => "show",
      :subcommand => "config",
      :sa         => "tss88888888",
      :type       => "running",
      :module_id  => '0',
    }

    c = Msh::Command::ShowConfigCommand.new
    c.stubs(:get_module_type).returns('plain')
    c.stubs(:execute).returns(response)

    c.doit(["show", "config", "tss88888888", "type", "running", "module", "0"])

    expected_str = <<EOS
hostname "seil"
interface lan1 add dhcp
route add default dhcp
EOS

    assert_equal(expected_str, $output.buffer)

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

end
