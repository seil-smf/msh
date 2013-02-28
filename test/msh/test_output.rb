# -*- coding: utf-8 -*-
require 'test_helper'

require 'msh/conf'
require 'msh/output'

class OutputTest < Test::Unit::TestCase
  Filename = "/tmp/msh_output_test_#{$$}"

  def test_new
    begin
      conf = Msh::Conf.new

      conf.merge!({ :output => "stderr" })
      o = Msh::Output.create(conf)
      assert_kind_of(Msh::Output::Stderr, o)
      assert_nothing_raised {
        o.puts "AAAAAAAAA!"
      }

      conf.merge!({ :output => "null" })
      o = Msh::Output.create(conf)
      assert_kind_of(Msh::Output::Null, o)
      assert_nothing_raised {
        o.puts "AAAAAAAAA!"
      }

      conf.merge!({ :output => "file", :output_file => Filename })
      o = Msh::Output.create(conf)
      assert_kind_of(Msh::Output::File, o)
      assert_nothing_raised {
        o.puts "AAAAAAAAA!"
      }

      conf.merge!({ :output => "buffer" })
      o = Msh::Output.create(conf)
      assert_kind_of(Msh::Output::Buffer, o)
      assert_nothing_raised {
        o.puts "AAAAAAAAA!"
      }
      assert_equal("AAAAAAAAA!\n", o.buffer)

      conf.merge!({ :output => nil })
      o = Msh::Output.create(conf)
      assert_kind_of(Msh::Output::Stdout, o)
      assert_nothing_raised {
        o.puts "AAAAAAAAA!"
      }
    ensure
      FileUtils.rm_f(Filename)
    end
  end
end
