# -*- coding: utf-8 -*-

require 'test_helper'

class CompletionAddTest < Test::Unit::TestCase
  def setup
    @completor = Msh::Completion::Completor.instance

    mock_cache = mock()
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

  def test_completion_add
    completion_test(
                    ['monitor', 'sagroup', 'template-set', 'template-variable'],
                    "",
                    "add ",
                    )
  end

  def test_completion_add_monitor
    completion_test(
                    ['monitor'],
                    "m",
                    "add m",
                    )

    completion_test(
                    ['<Monitor Name>', '　'],
                    "",
                    "add monitor ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "add monitor 'Monitor Group' "
                    )
  end

  def test_completion_add_sagroup
    completion_test(
                    ['sagroup'],
                    "s",
                    "add s",
                    )

    completion_test(
                    ['<SA Group Name>', '　'],
                    "",
                    "add sagroup ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "add sagroup 'SA Group' ",
                    )
  end

  def test_completion_add_template_set
    completion_test(
                    ['template-set'],
                    "template-s",
                    "add template-s",
                    )

    completion_test(
                    ["<TemplateSet Name>", "　"],
                    "",
                    "add template-set ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "add template-set TemplateSet ",
                    )
  end

  def test_completion_add_template_variable
    completion_test(
                    ['template-variable'],
                    "template-v",
                    "add template-v",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "add template-variable "
                    )

    completion_test(
                    ['<TemplateVariable Name>', '　'],
                    "",
                    "add template-variable 1 ",
                    )

    completion_test(
                    ['defaultvalue', '(Enter)'],
                    "",
                    "add template-variable 1 LAN0 ",
                    )

    completion_test(
                    ['<Default Value>', '　'],
                    "",
                    "add template-variable 1 LAN0 defaultvalue ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "add template-variable 1 LAN0 defaultvalue dhcp ",
                    )
  end

end
