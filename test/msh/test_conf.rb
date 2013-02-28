# -*- coding: utf-8 -*-
require 'test_helper'
require 'msh/conf'

class ConfTest < Test::Unit::TestCase
  def test_new
    filename = File.join(File.dirname(File.expand_path(__FILE__)), "example.conf")

    conf = Msh::Conf.new(filename).read

    assert_equal("tsa********", conf[:user_code])
    assert_equal(nil, conf[:dummy])
    assert_kind_of(Hash, conf)
  end
end
