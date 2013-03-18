# -*- coding: utf-8 -*-

require 'test_helper'

class CompletionSetTest < Test::Unit::TestCase
  def setup
    @completor = Msh::Completion::Completor.instance

    mock_cache = mock()
    mock_cache.stubs(:sa_code).returns(["tsw00000000", "tss11111111"])
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

  def test_completion_set
    completion_test(
                    ['config', 'monitor', 'sa', 'sagroup', 'template-set', 'template-variable', 'template-config', 'module', 'env', 'mshrc'],
                    "",
                    "set ",
                    )
  end

  def test_completion_set_config
    completion_test(
                    ['config'],
                    "c",
                    "set c",
                    )

    completion_test(
                    ['tsw00000000','tss11111111'],
                    "",
                    "set config ",
                    )

    completion_test(
                    ['working'],
                    "w",
                    "set config tsw00000000 ",
                    )

    completion_test(
                    ['module'],
                    "",
                    "set config tsw00000000 working ",
                    )

    completion_test(
                    ["<Module ID>", "　"],
                    "",
                    "set config tsw00000000 working module ",
                    )

    completion_test(
                    ["config", "(Enter)"],
                    "",
                    "set config tsw00000000 working module 0 ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set config tsw00000000 working module 0 config /tmp/conf ",
                    )

    completion_test(
                    ['running'],
                    "r",
                    "set config tsw00000000 ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set config tsw00000000 running "
                    )

    completion_test(
                    ['startup'],
                    "s",
                    "set config tsw00000000 ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set config tsw00000000 startup ",
                    )
  end

  def test_completion_set_monitor
    completion_test(
                    ['monitor'],
                    "mon",
                    "set mon",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "set monitor ",
                    )

    completion_test(
                    ["name", "reports", "sa"],
                    "",
                    "set monitor 1 ",
                    )

    completion_test(
                    ["<Mail>", "　"],
                    "",
                    "set monitor 1 reports ",
                    )

    completion_test(
                    ["name", "sa", "<Mail>", "(Enter)"],
                    "",
                    "set monitor 1 reports example@example.jp "
                    )

    completion_test(
                    ["<SA>", "　"],
                    "",
                    "set monitor 1 reports example@example.jp sa "
                    )

    completion_test(
                    ["name", "<SA>", "(Enter)"],
                    "",
                    "set monitor 1 reports example@example.jp sa tsw00000000 ",
                    )

    completion_test(
                    ["<Name>", "　"],
                    "",
                    "set monitor 1 reports example@example.jp sa tsw00000000 name ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set monitor 1 reports example@example.jp sa tsw00000000 name Monitor "
                    )

  end


  def test_completion_set_sa

    completion_test(
                    ['sa', 'sagroup'],
                    "s",
                    "set s",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "set sa ",
                    )

    completion_test(
                    ["name", "description", "distributionid", "preferredpushmethod"],
                    "",
                    "set sa tsw00000000 "
                    )

    completion_test(
                    ["<Name>", "　"],
                    "",
                    "set sa tsw00000000 name ",
                    )

    completion_test(
                    ["description", "distributionid", "preferredpushmethod", "(Enter)"],
                    "",
                    "set sa tsw00000000 name 'SA Label' ",
                    )

    completion_test(
                    ["<Description>", "　"],
                    "",
                    "set sa tsw00000000 name 'SA Label' description ",
                    )

    completion_test(
                    ["distributionid", "preferredpushmethod", "(Enter)"],
                    "",
                    "set sa tsw00000000 name 'SA Label' description 'メモ 1'",
                    )

    completion_test(
                    ["<Distribution ID>","　"],
                    "",
                    "set sa tsw00000000 name 'SA Label' description 'メモ 1' distributionid ",
                    )

    completion_test(
                    ["preferredpushmethod", "(Enter)"],
                    "",
                    "set sa tsw00000000 name 'SA Label' description 'メモ 1' distributionid 0000-0000-0000-0000-0000-0000-0000-0000 ",
                    )

    completion_test(
                    ["<Preferred Push Method>", "　"],
                    "",
                    "set sa tsw00000000 name 'SA Label' description 'メモ 1' distributionid 0000-0000-0000-0000-0000-0000-0000-0000 preferredpushmethod ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set sa tsw00000000 name 'SA Label' description 'メモ 1' distributionid 0000-0000-0000-0000-0000-0000-0000-0000 preferredpushmethod none ",
                    )

  end

  def test_completion_set_sagroup
    completion_test(
                    ["sagroup"],
                    "sag",
                    "set sag",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "set sagroup ",
                    )

    completion_test(
                    ["name", "sa"],
                    "",
                    "set sagroup 1 ",
                    )

    completion_test(
                    ["<SA Group Name>", "　"],
                    "",
                    "set sagroup 1 name ",
                    )

    completion_test(
                    ["sa", "(Enter)"],
                    "",
                    "set sagroup 1 name 'SA Group'",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "set sagroup 1 name 'SA Group' sa ",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111", "(Enter)"],
                    "",
                    "set sagroup 1 name 'SA Group' sa tsw00000000 ",
                    )
  end

  def test_completion_set_template_set
    completion_test(
                    ["template-set"],
                    "template-s",
                    "set template-s",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "set template-set ",
                    )

    completion_test(
                    ["sa", "name", "csv"],
                    "",
                    "set template-set 1 ",
                    )

    completion_test(
                    ["<CSV Path>", "　"],
                    "",
                    "set template-set 1 csv ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set template-set 1 csv /tmp/template.csv ",
                    )

    completion_test(
                   ["tsw00000000", "tss11111111"],
                    "",
                    "set template-set 1 sa ",
                    )

    completion_test(
                   ["name", "(Enter)", "tsw00000000", "tss11111111"],
                    "",
                    "set template-set 1 sa tsw00000000 ",
                    )

    completion_test(
                   ["name", "(Enter)", "tsw00000000", "tss11111111"],
                    "",
                    "set template-set 1 sa tsw00000000 tss11111111 ",
                    )

    completion_test(
                    ["<Name>", "　"],
                    "",
                    "set template-set 1 sa tsw00000000 tss11111111 name ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set template-set 1 sa tsw00000000 tss11111111 name 'SA Group'",
                    )

  end

  def test_completion_set_template_variable
    completion_test(
                    ["template-variable"],
                    "template-v",
                    "set template-v",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "set template-variable ",
                    )

    completion_test(
                    ["LAN0", "LAN1"],
                    "",
                    "set template-variable 1 ",
                    )

    completion_test(
                    ["defaultvalue", "values"],
                    "",
                    "set template-variable 1 LAN0 ",
                    )

    completion_test(
                    ["<default Value>", "　"],
                    "",
                    "set template-variable 1 LAN0 defaultvalue ",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "set template-variable 1 LAN0 values ",
                    )

    completion_test(
                    ["<Value>", "　"],
                    "",
                    "set template-variable 1 LAN0 values tsw00000000 ",
                    )

  end

  def test_completion_set_template_config
    completion_test(
                    ["template-config"],
                    "template-c",
                    "set template-c",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "set template-config ",
                    )

    completion_test(
                    ["<Module ID>", "　"],
                    "",
                    "set template-config 1 ",
                    )

    completion_test(
                    ["config", "(Enter)"],
                    "",
                    "set template-config 1 0 ",
                    )

    completion_test(
                    ["<Config PATH>", "　"],
                    "",
                    "set template-config 1 0 config ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "set template-config 1 0 config /tmp/template_config ",
                    )
  end

  def test_completion_set_module
    completion_test(
                    ["module"],
                    "mod",
                    "set mod",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "set module ",
                    )

    completion_test(
                    ['<Module ID>', '　'],
                    "",
                    "set module tsw00000000 ",
                    )

    completion_test(
                    ['<Version>', '　'],
                    "",
                    "set module tsw00000000 0 ",
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "set module tsw00000000 0 1.0.0-0 ",
                    )

  end

  def test_completion_set_env
    completion_test(
                    ["env"],
                    "en",
                    "set en",
                    )

    completion_test(
                    ['access_key', 'access_key_secret', 'domain', 'path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', 'offset_minute'],
                    "",
                    "set env ",
                    )

    completion_test(
                    ['access_key', 'access_key_secret'],
                    "a",
                    "set env a",
                    )

    completion_test(
                    ['<access_key>', '　'],
                    "",
                    "set env access_key ",
                    )

    completion_test(
                    ['access_key_secret', 'domain', 'path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', 'offset_minute', '(Enter)'],
                    "",
                    "set env access_key Key ",
                    )

    completion_test(
                    ['access_key_secret'],
                    "a",
                    "set env access_key Key a"
                    )

    completion_test(
                    ['<access_key_secret>', '　'],
                    "",
                    "set env access_key Key access_key_secret "
                    )

    completion_test(
                    ['domain', 'path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', 'offset_minute', '(Enter)'],
                    "",
                    "set env access_key Key access_key_secret secret "
                    )

    completion_test(
                    ['domain'],
                    "d",
                    "set env access_key Key access_key_secret secret d"
                    )

    completion_test(
                    ['<domain>', '　'],
                    "",
                    "set env access_key Key access_key_secret secret domain "
                    )

    completion_test(
                    ['path', 'user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', 'offset_minute', '(Enter)'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp "
                    )

    completion_test(
                    ['path'],
                    "pa",
                    "set env access_key Key access_key_secret secret domain sacm.jp pa"
                    )

    completion_test(
                    ['<path>', '　'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path "
                    )

    completion_test(
                    ['user_code', 'proxy_addr', 'proxy_port', 'ssl_verify', 'offset_minute', '(Enter)'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api "
                    )

    completion_test(
                    ['user_code'],
                    "u",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api u"
                    )

    completion_test(
                    ['<user_code>', '　'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code "
                    )

    completion_test(
                    ['proxy_addr', 'proxy_port', 'ssl_verify', 'offset_minute', '(Enter)'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code tsa00000000 "
                    )

    completion_test(
                    ['proxy_addr'],
                    "proxy_a",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code tsa00000000 proxy_a"
                    )

    completion_test(
                    ['<proxy_addr>', '　'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code tsa00000000 proxy_addr "
                    )

    completion_test(
                    ['proxy_port', 'ssl_verify', 'offset_minute', '(Enter)'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code tsa00000000 proxy_addr proxy.jp "
                    )

    completion_test(
                    ['proxy_port'],
                    "p",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code tsa00000000 proxy_addr proxy.jp p",
                    )

    completion_test(
                    ['<proxy_port>', '　'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code tsa00000000 proxy_addr proxy.jp proxy_port ",
                    )

    completion_test(
                    ['ssl_verify', 'offset_minute', '(Enter)'],
                    "",
                    "set env access_key Key access_key_secret secret domain sacm.jp path /api user_code tsa00000000 proxy_addr proxy.jp proxy_port 8081 ",
                    )

    completion_test(
                    ['ssl_verify'],
                    "s",
                    "set env access_key access_key_secret domain path user_code proxy_addr proxy_port 8081 s"
                    )

    completion_test(
                    ['true', 'false'],
                    "",
                    "set env access_key access_key_secret domain path user_code proxy_addr proxy_port 8081 ssl_verify "
                    )

    completion_test(
                    ['offset_minute', '(Enter)'],
                    "",
                    "set env access_key access_key_secret domain path user_code proxy_addr proxy_port 8081 ssl_verify true "
                    )

    completion_test(
                    ['offset_minute'],
                    "o",
                    "set env access_key access_key_secret domain path user_code proxy_addr proxy_port 8081 ssl_verify true o"
                    )

    completion_test(
                    ['<-720 - 840>', '　'],
                    "",
                    "set env access_key access_key_secret domain path user_code proxy_addr proxy_port 8081 ssl_verify true offset_minute "
                    )

    completion_test(
                    ['(Enter)', '　'],
                    "",
                    "set env access_key access_key_secret domain path user_code proxy_addr proxy_port 8081 ssl_verify true offset_minute 540 "
                    )
  end

end
