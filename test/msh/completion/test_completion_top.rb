# -*- coding: utf-8 -*-

require 'test_helper'

class CompletionTopTest < Test::Unit::TestCase
  def setup
    @completor = Msh::Completion::Completor.instance
  end

  def test_completion_top
    completion_test(
["ping", "traceroute", "read-storage", "reboot", "read-status", "clear-status", "md-command", "show", "quit", "exit", "help", "add", "set", "unset", "delete"],
                    "",
                    "",
                    )
  end

end
