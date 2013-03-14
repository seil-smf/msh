# -*- coding: utf-8 -*-

require 'test_helper'

class SetMshrcCommandTest < Test::Unit::TestCase
  def setup
    $conf = mock()
    $conf.expects(:set_mshrc).returns("conf")
    $conf.expects(:read).returns("conf")
    $conf.expects(:puts_conf).returns("conf")
  end

  def test_no_option
    $output = Msh::Output::Buffer.new

    c = Msh::Command::SetMshrcCommand.new

    c.doit(["set", "mshrc", "mshrc.default"])
  end

end
