# -*- coding: utf-8 -*-

require 'test_helper'

require 'msh/command/unknown_command_command'
require 'msh/output'

class UnknownCommandCommandTest < Test::Unit::TestCase
  def test_unknown_command
    $output = Msh::Output::Buffer.new

    c = Msh::Command::UnknownCommandCommand.new
    c.doit(["unknown command"])

    assert_kind_of(String, $output.buffer)
    assert_equal("unknown command is unknown command.\n", $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end
end
