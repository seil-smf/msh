# -*- coding: utf-8 -*-

require 'test_helper'

class CompletionShowTest < Test::Unit::TestCase
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


  def test_completion_show
    completion_test(
                    ["event", "config", "request", "monitor", "user", "sa", "sagroup", "template-set", "template-variable", "template-config", "module", "env", "mshrc"],
                    "",
                    "show ",
                    )
  end

  def test_completion_show_user
    completion_test(
                    ["user"],
                    "u",
                    "show u",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show user ",
                    )
  end


  def test_completion_show_sa
    completion_test(
                    ["sa", "sagroup"],
                    "s",
                    "show s",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111", "(Enter)"],
                    "",
                    "show sa ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show sa tsw00000000 "
                    )
  end

  def test_completion_show_config
    completion_test(
                    ["config"],
                    "c",
                    "show c",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "show config ",
                    )

    completion_test(
                    ["type", "(Enter)"],
                    "",
                    "show config tsw00000000 ",
                    )

    completion_test(
                    ["working", "preview", "running", "startup"],
                    "",
                    "show config tsw00000000 type ",
                    )

    completion_test(
                    ["module", "(Enter)"],
                    "",
                    "show config tsw00000000 type working ",
                    )

    completion_test(
                    ["<Module ID>", "　"],
                    "",
                    "show config tsw00000000 type working module ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show config tsw00000000 type working module 1 ",
                    )

  end

  def test_completion_show_module
    completion_test(
                    ["module"],
                    "mod",
                    "show mod",
                    )

    completion_test(
                    ['(Enter)', "　"],
                    "",
                    "show module ",
                    )
  end

  def test_completion_show_request
    completion_test(
                    ["request"],
                    "r",
                    "show r",
                    )

    completion_test(
                    ["sa", "status", "type", "(Enter)"],
                    "",
                    "show request ",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "show request sa ",
                    )

    completion_test(
                    ["status", "type", "(Enter)"],
                    "",
                    "show request sa tsw00000000 ",
                    )

    completion_test(
                    ["<Status>", "　"],
                    "",
                    "show request sa tsw00000000 status ",
                    )

    completion_test(
                    ["type", "<Status>", "(Enter)"],
                    "",
                    "show request sa tsw00000000 status successed ",
                    )

    completion_test(
                    ["ping", "traceroute", "read-storage", "reboot", "read-status", "clear-status", "md-command"],
                    "",
                    "show request sa tsw00000000 status successed type ",
                    )

    completion_test(
                    ["id", "(Enter)"],
                    "",
                    "show request sa tsw00000000 status successed type ping ",
                    )

    completion_test(
                    ["<Request ID>", "　"],
                    "",
                    "show request sa tsw00000000 status successed type ping id ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show request sa tsw00000000 status successed type ping id 1:1 ",
                    )
  end

  def test_completion_show_event
    completion_test(
                    ['event'],
                    "ev",
                    "show ev",
                    )

    completion_test(
                    ["sa", "type", "(Enter)"],
                    "",
                    "show event ",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "show event sa ",
                    )

    completion_test(
                    ["type", "(Enter)"],
                    "",
                    "show event sa tsw00000000 ",
                    )

    completion_test(
                    ["configure", "monitor", "request"],
                    "",
                    "show event sa tsw00000000 type ",
                    )
  end


  def test_completion_show_monitor
    expected_candidates = ["monitor"]

    word = "mon"
    input = "show mon"

    candidates = @completor.doit(input).grep(/\A#{Regexp.quote word}/)

    assert_kind_of(Array, candidates)
    assert_equal(expected_candidates, candidates)


    expected_candidates = ["1", "3", "(Enter)"]

    word = ""
    input = "show monitor "

    candidates = @completor.doit(input).grep(/\A#{Regexp.quote word}/)

    assert_kind_of(Array, candidates)
    assert_equal(expected_candidates, candidates)


    expected_candidates = ["(Enter)", "　"]

    word = ""
    input = "show monitor 1 "

    candidates = @completor.doit(input).grep(/\A#{Regexp.quote word}/)

    assert_kind_of(Array, candidates)
    assert_equal(expected_candidates, candidates)
  end

  def test_completion_show_sagroup
    completion_test(
                    ["sagroup"],
                    "sag",
                    "show sag",
                    )

    completion_test(
                    ["1", "3", "(Enter)"],
                    "",
                    "show sagroup ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show sagroup 1 ",
                    )

  end

  def test_completion_show_template_set
    completion_test(
                    ["template-set"],
                    "template-s",
                    "show template-s",
                    )

    completion_test(
                    ["id", "(Enter)"],
                    "",
                    "show template-set ",
                    )

    completion_test(
                    ["1", "3", "(Enter)"],
                    "",
                    "show template-set id ",
                    )

    completion_test(
                    ["(Enter)", "csv"],
                    "",
                    "show template-set id 1 ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show template-set id 1 csv ",
                    )

  end

  def test_completion_show_template_variable
    completion_test(
                    ["template-variable"],
                    "template-v",
                    "show template-v",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "show template-variable ",
                    )

    completion_test(
                    ["name", "(Enter)"],
                    "",
                    "show template-variable 1 ",
                    )

    completion_test(
                    ["LAN0", "LAN1", "(Enter)"],
                    "",
                    "show template-variable 1 name ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show template-variable 1 name LAN0 ",
                    )

  end

  def test_completion_show_template_config
    completion_test(
                    ["template-config"],
                    "template-c",
                    "show template-c",
                    )

    completion_test(
                    ["1", "3"],
                    "",
                    "show template-config ",
                    )

    completion_test(
                    ["<Module ID>", "(Enter)"],
                    "",
                    "show template-config 1 ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show template-config 1 0 ",
                    )

  end

  def test_completion_show_env
    completion_test(
                    ["env"],
                    "en",
                    "show en",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show env ",
                    )

  end

  def test_completion_show_mshrc
    completion_test(
                    ["mshrc"],
                    "ms",
                    "show ms",
                    )


    word = ""
    input = "show monitor 1 "

    candidates = @completor.doit(input).grep(/\A#{Regexp.quote word}/)

    assert_kind_of(Array, candidates)


    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "show mshrc mshrc ",
                    )

  end

end
