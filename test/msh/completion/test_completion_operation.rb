# -*- coding: utf-8 -*-

require 'test_helper'

class CompletionOperationTest < Test::Unit::TestCase
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

  def test_completion_ping
    completion_test(
                    ["ping"],
                    "p",
                    "p",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "ping ",
                    )

    completion_test(
                    ["<IP Address>", "　"],
                    "",
                    "ping tsw00000000 ",
                    )

    completion_test(
                    ["targettime", "count", "size", "(Enter)"],
                    "",
                    "ping tsw00000000 192.168.0.1 ",
                    )

    completion_test(
                    ["<targetTime>", "　"],
                    "",
                    "ping tsw00000000 192.168.0.1 targettime ",
                    )

    completion_test(
                    ["count", "size", "(Enter)"],
                    "",
                    "ping tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 ",
                    )

    completion_test(
                    ["<count>", "　"],
                    "",
                    "ping tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count ",
                    )

    completion_test(
                    ["size", "(Enter)"],
                    "",
                    "ping tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count 5 ",
                    )

    completion_test(
                    ["<size>", "　"],
                    "",
                    "ping tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count 5 size ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "ping tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count 5 size 30 ",
                    )

  end

  def test_completion_traceroute
    completion_test(
                    ["traceroute"],
                    "tr",
                    "tr",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "traceroute ",
                    )

    completion_test(
                    ["<IP Address>", "　"],
                    "",
                    "traceroute tsw00000000 ",
                    )

    completion_test(
                    ["targettime", "count", "maxhop", "(Enter)"],
                    "",
                    "traceroute tsw00000000 192.168.0.1 ",
                    )

    completion_test(
                    ["<targetTime>", "　"],
                    "",
                    "traceroute tsw00000000 192.168.0.1 targettime ",
                    )

    completion_test(
                    ["count", "maxhop", "(Enter)"],
                    "",
                    "traceroute tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 ",
                    )

    completion_test(
                    ["<count>", "　"],
                    "",
                    "traceroute tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count ",
                    )

    completion_test(
                    ["maxhop", "(Enter)"],
                    "",
                    "traceroute tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count 5 ",
                    )

    completion_test(
                    ["<maxHop>", "　"],
                    "",
                    "traceroute tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count 5 maxhop ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "traceroute tsw00000000 192.168.0.1 targettime 2013/01/01 00:00:00 count 5 maxhop 30 ",
                    )
  end

  def test_completion_read_storage
    completion_test(
                    ["read-storage"],
                    "read-sto",
                    "read-sto",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "read-storage ",
                    )

    completion_test(
                    ["startup", "running", "backup"],
                    "",
                    "read-storage tsw00000000 ",
                    )

    completion_test(
                    ["targettime", "(Enter)"],
                    "",
                    "read-storage tsw00000000 running ",
                    )

    completion_test(
                    ["<targetTime>", "　"],
                    "",
                    "read-storage tsw00000000 running targettime ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "read-storage tsw00000000 running targettime 2013/01/01 00:00:00 ",
                    )
  end

  def test_completion_reboot
    completion_test(
                    ["reboot"],
                    "reb",
                    "reb",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "reboot ",
                    )

    completion_test(
                    ["targettime", "(Enter)"],
                    "",
                    "reboot tsw00000000 ",
                    )

    completion_test(
                    ["<targetTime>", "　"],
                    "",
                    "reboot tsw00000000 targettime ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "reboot tsw00000000 targettime 2013/01/01 00:00:00 ",
                    )
  end

  def test_completion_read_status
    completion_test(
                    ["read-status"],
                    "read-sta",
                    "read-sta",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "read-status ",
                    )

    completion_test(
                    ["<Module ID>", "　"],
                    "",
                    "read-status tsw00000000 ",
                    )

    completion_test(
                    ["<Command>", "　"],
                    "",
                    "read-status tsw00000000 0 ",
                    )

    completion_test(
                    ["targettime","<Command>", "(Enter)"],
                    "",
                    "read-status tsw00000000 0 show system ",
                    )

    completion_test(
                    ["<targetTime>", "　"],
                    "",
                    "read-status tsw00000000 0 show system targettime ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "read-status tsw00000000 0 show system targettime 2013/01/01 00:00:00 ",
                    )
  end

  def test_completion_clear_status
    completion_test(
                    ["clear-status"],
                    "c",
                    "c",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "clear-status ",
                    )

    completion_test(
                    ["<Module ID>", "　"],
                    "",
                    "clear-status tsw00000000 ",
                    )

    completion_test(
                    ["<Command>", "　"],
                    "",
                    "clear-status tsw00000000 0 ",
                    )

    completion_test(
                    ["targettime","<Command>", "(Enter)"],
                    "",
                    "clear-status tsw00000000 0 clear nat-session ipv4 ",
                    )

    completion_test(
                    ["<targetTime>", "　"],
                    "",
                    "clear-status tsw00000000 0 clear nat-session ipv4 targettime ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "clear-status tsw00000000 0 clear nat-session ipv4 targettime 2013/01/01 00:00:00 ",
                    )
  end

  def test_completion_md_command
    completion_test(
                    ["md-command"],
                    "md",
                    "md",
                    )

    completion_test(
                    ["tsw00000000", "tss11111111"],
                    "",
                    "md-command ",
                    )

    completion_test(
                    ["<Module ID>", "　"],
                    "",
                    "md-command tsw00000000 ",
                    )

    completion_test(
                    ["<Command>", "　"],
                    "",
                    "md-command tsw00000000 0 ",
                    )

    completion_test(
                    ["targettime","<Command>", "(Enter)"],
                    "",
                    "md-command tsw00000000 0 ping 127.0.0.1 count 5 ",
                    )

    completion_test(
                    ["<targetTime>", "　"],
                    "",
                    "md-command tsw00000000 0 ping 127.0.0.1 count 5 targettime ",
                    )

    completion_test(
                    ["(Enter)", "　"],
                    "",
                    "md-command tsw00000000 0 ping 127.0.0.1 count 5 targettime 2013/01/01 00:00:00 ",
                    )
  end

end
