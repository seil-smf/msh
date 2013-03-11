# -*- coding: utf-8 -*-

require 'test_helper'

class CompletionUnsetTest < Test::Unit::TestCase
  def setup
    @completor = Msh::Completion::Completor.instance

    mock_cache = mock()
    mock_cache.stubs(:sa_code).returns(["tsw00000000", "tss00000000"])
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

  def test_completion_unset
    completion_test(
                    ['monitor', 'sa', 'sagroup', 'template-set', 'env'],
                    "",
                    "unset ",
                    )

    completion_test(
                    ['sa', 'sagroup'],
                    "s",
                    "unset s",
                    )

    completion_test(
                    ["tsw00000000", "tss00000000"],
                    "",
                    "unset sa ",
                    )

    completion_test(
                    ["name", "description", "distributionid", "preferredpushmethod"],
                    "",
                    "unset sa tsw00000000 "
                    )

    completion_test(
                    ["description", "distributionid", "preferredpushmethod", "(Enter)"],
                    "",
                    "unset sa tsw00000000 name "
                    )

    completion_test(
                    ["distributionid", "preferredpushmethod", "(Enter)"],
                    "",
                    "unset sa tsw00000000 name description "
                    )

    completion_test(
                    ["preferredpushmethod", "(Enter)"],
                    "",
                    "unset sa tsw00000000 name description distributionid"
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "unset sa tsw00000000 name description distributionid preferredpushmethod",
                    )
  end

  def test_completion_unset_monitor
    completion_test(
                    ['monitor'],
                    "mon",
                    "unset mon"
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "unset monitor "
                    )

    completion_test(
                    ["reports", "sa", "(Enter)"],
                    "",
                    "unset monitor 1 name "
                    )

    completion_test(
                    ["sa", "(Enter)"],
                    "",
                    "unset monitor 1 name reports "
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "unset monitor 1 name reports sa "
                    )
  end

  def test_completion_unset_sagroup
    completion_test(
                    ['sagroup'],
                    "sag",
                    "unset sag",
                    )

    completion_test(
                    ['1', '3'],
                    "",
                    "unset sagroup ",
                    )

    completion_test(
                    ["name", "sa"],
                    "",
                    "unset sagroup 1 ",
                    )

    completion_test(
                    ["(Enter)", "sa"],
                    "",
                    "unset sagroup 1 name ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "unset sagroup 1 name sa "
                    )
  end

  def test_completion_unset_template_set
    completion_test(
                    ['template-set'],
                    "template-s",
                    "unset template-s",
                    )

    completion_test(
                    ['1', '3'],
                    "",
                    "unset template-set "
                    )

    completion_test(
                    ['sa', 'name'],
                    "",
                    "unset template-set 1 ",
                    )

    completion_test(
                    ['name', '(Enter)'],
                    "",
                    "unset template-set 1 sa ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "unset template-set 1 sa name ",
                    )
  end


  def test_completion_unset_env
    completion_test(
                    ['env'],
                    "e",
                    "unset e",
                    )

    completion_test(
                    ['access_key', 'access_key_secret', 'domain', 'path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify'],
                    "",
                    "unset env ",
                    )

    completion_test(
                    ['access_key', 'access_key_secret'],
                    "a",
                    "unset env a",
                    )

    completion_test(
                    ['access_key_secret', 'domain', 'path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', '(Enter)'],
                    "",
                    "unset env access_key ",
                    )

    completion_test(
                    ['access_key_secret'],
                    "a",
                    "unset env access_key a"
                    )

    completion_test(
                    ['domain', 'path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', '(Enter)'],
                    "",
                    "unset env access_key access_key_secret "
                    )

    completion_test(
                    ['domain'],
                    "d",
                    "unset env access_key access_key_secret d"
                    )

    completion_test(
                    ['path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', '(Enter)'],
                    "",
                    "unset env access_key access_key_secret domain "
                    )

    completion_test(
                    ['path'],
                    "pa",
                    "unset env access_key access_key_secret domain pa"
                    )

    completion_test(
                    ['user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', '(Enter)'],
                    "",
                    "unset env access_key access_key_secret domain path "
                    )

    completion_test(
                    ['user_code'],
                    "u",
                    "unset env access_key access_key_secret domain path u"
                    )

    completion_test(
                    ['proxy_addr', 'proxy_port', 'ssl_verify', '(Enter)'],
                    "",
                    "unset env access_key access_key_secret domain path user_code "
                    )

    completion_test(
                    ['proxy_addr'],
                    "proxy_a",
                    "unset env access_key access_key_secret domain path user_code proxy_a"
                    )

    completion_test(
                    ['proxy_port', 'ssl_verify', '(Enter)'],
                    "",
                    "unset env access_key access_key_secret domain path user_code proxy_addr "
                    )

    completion_test(
                    ['proxy_port'],
                    "p",
                    "unset env access_key access_key_secret domain path user_code proxy_addr p"
                    )


    completion_test(
                    ['ssl_verify', '(Enter)'],
                    "",
                    "unset env access_key access_key_secret domain path user_code proxy_addr proxy_port "
                    )

    completion_test(
                    ['ssl_verify'],
                    "s",
                    "unset env access_key access_key_secret domain path user_code proxy_addr proxy_port s"
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
"unset env access_key access_key_secret domain path user_code proxy_addr proxy_port ssl_verify",
                    )
  end

end
