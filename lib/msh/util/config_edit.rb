# -*- coding: utf-8 -*-
require "fileutils"

module Msh
  class ConfigEdit
    def initialize
      @config_file = "/tmp/msh_config_#{(Time.now).strftime("%Y%m%d_%H%M%S")}.txt"
      FileUtils.touch(@config_file)
      @config = nil
    end

    def get_config
      @config
    end

    def doit
      begin
        if ENV['EDITOR'] && FileTest.executable?(ENV['EDITOR'])
          fork do
            exec(ENV['EDITOR'], @config_file)
          end
          pid_stat = Process.wait2

          File.open(@config_file, "r") do |f|
            @config = f.read
          end
        else
          $output.puts 'please enter data ("." for end of data)'
          @config = ""
          loop do
            line = $stdin.gets
            break if /^\.$/ =~ line.chomp
            @config += line
          end
        end
      rescue => e
        $output.puts e
      ensure
        FileUtils.rm(@config_file)
      end
    end
  end
end
