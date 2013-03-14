# -*- coding: utf-8 -*-

require 'test_helper'

class ShowMshrcCommandTest < Test::Unit::TestCase
  def setup
  end

  def test_no_option
    $output = Msh::Output::Buffer.new

    c = Msh::Command::ShowMshrcCommand.new

    c.doit(["show", "mshrc", "mshrc.test"])
  end

end
