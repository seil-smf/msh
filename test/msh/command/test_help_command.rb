# -*- coding: utf-8 -*-

require 'test_helper'

class HelpCommandTest < Test::Unit::TestCase
  def test_no_option
    $output = Msh::Output::Buffer.new

    c = Msh::Command::HelpCommand.new
    c.doit(["help"])

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_subcommand
    $output = Msh::Output::Buffer.new

    c = Msh::Command::HelpCommand.new
    c.doit(["help", "check-transaction"])

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  def test_nonexistent_subcommand
    $output = Msh::Output::Buffer.new

    c = Msh::Command::HelpCommand.new
    c.doit(["help", "xxxxxxxxxxxxxxx"])

    assert_kind_of(String, $output.buffer)
    assert("Can not find the help for the command\n", $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end
end
