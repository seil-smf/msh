require 'test_helper'

class MshTest < Test::Unit::TestCase
  def test_msh_module
    assert(Msh)
  end

  def test_msh_start
    assert(defined?(Msh.start))

    shell = mock()
    shell.stubs(:run).returns(true)
    shell.stubs(:non_interactive_run).returns(true)

    Msh::Cli.stubs(:new).returns(shell)

    assert(Msh.start([""]))
    assert(Msh.start([]))
  end

end
