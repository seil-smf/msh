# -*- coding: utf-8 -*-

require 'test_helper'

require 'mocha'

require 'msh/command/show_env_command'
require 'msh/output'

class ShowEnvCommandTest < Test::Unit::TestCase
  def setup
    $conf = Msh::Conf.new.merge!(
                 {
                   :proxy_addr        => "proxy.example.jp",
                   :proxy_port        => "8080",
                   :domain            => "server.example.jp",
                   :path              => "/public-api/v1",
                   :access_key        => "xxxxxxxxxxxxxx",
                   :access_key_secret => "yyyyyyyyyyyyyyyyy",
                   :user_code         => "tsa99999999",
                 }
                 )
  end

  def test_no_subcommand
    $output = Msh::Output::Buffer.new

    c = Msh::Command::ShowEnvCommand.new
    c.doit(["show", "env"])

    assert_kind_of(String, $output.buffer)
    assert(! $output.buffer.nil?)
    assert(! $output.buffer.empty?)
  end

  # TODO オプションを指定した場合のテストケースを追加する
end
