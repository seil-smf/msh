# -*- coding: utf-8 -*-

require 'test_helper'

class CompletionDeleteTest < Test::Unit::TestCase
  def setup
    @completor = Msh::Completion::Completor.instance

    mock_cache = mock()
    mock_cache.stubs(:monitor_id).returns(["1", "3"])
    mock_cache.stubs(:sagroup_id).returns(["1", "3"])
    mock_cache.stubs(:template_set_id).returns(["1", "3"])
    mock_cache.stubs(:template_variable_name).returns({
                                                       "1" => ["LAN0", "LAN1"],
                                                       "3" => ["LAN2", "LAN3"],
                                                      })

    $cache = mock_cache
  end

  def teardown
    $cache = nil
  end

  def test_completion_delete
    completion_test(
                    ['monitor', 'sagroup', 'template-set', 'template-variable', 'template-config'],
                    "",
                    "delete ",
                    )
  end

  def test_completion_delete_monitor
    completion_test(
                    ['monitor'],
                    "m",
                    "delete m",
                    )

    completion_test(
                    ['1', '3'],
                    "",
                    "delete monitor ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "delete monitor 1 ",
                    )
  end

  def test_completion_delete_sagroup
    completion_test(
                    ['sagroup'],
                    "sag",
                    "delete sag",
                    )

    completion_test(
                    ['1', '3'],
                    "",
                    "delete sagroup ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "delete sagroup 1 ",
                    )
  end

  def test_completion_delete_template_variable
    completion_test(
                    ['template-variable'],
                    "template-v",
                    "delete template-v",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "delete template-variable ",
                    )

    completion_test(
                    ['LAN0', 'LAN1'],
                    "",
                    "delete template-variable 1 "
                    )

    completion_test(
                    ['(Enter)', "　"],
                    "",
                    "delete template-variable 1 LAN0 ",
                    )
  end

  def test_completion_delete_template_set
    completion_test(
                    ['template-set'],
                    "template-s",
                    "delete template-s",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "delete template-set ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "delete template-set 1 ",
                    )
  end


  def test_completion_delete_template_config
    completion_test(
                    ['template-config'],
                    "template-c",
                    "delete template-c",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "delete template-config ",
                    )

    completion_test(
                    ['<Module ID>', '　'],
                    "",
                    "delete template-config 1 ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "delete template-config 1 0 "
                    )
  end

end
