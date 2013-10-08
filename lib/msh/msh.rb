#!/usr/bin/env ruby -v
# -*- coding: utf-8 -*-

require 'readline'
require 'nkf'
require 'strscan'

require 'msh/conf'
require 'msh/output'
require 'msh/client/sacmapiclient'

require 'msh/command'
require 'msh/command/abstract_command'
require 'msh/command_table'
require 'msh/completion'
require 'msh/version'
require 'msh/cache/cache'

module Msh
  class Cli
    def initialize
      $output = Msh::Output.create($conf)
      load_history
      $cache = Msh::Cache.new
    end

    def run
      begin
        loop do
          begin
            Readline.completion_proc = proc {|word|
              comp = Msh::Completion::Completor.instance
              comp.doit(Readline.line_buffer).grep(/^#{Regexp.quote word}/)
            }

            line = Readline.readline("msh(#{$conf[:user_code]})> ", true)
            line = NKF.nkf("-w -m0", line) if line

            Readline::HISTORY.pop if /^\s*$/ =~ line
            next if line == ''

            if line.nil?
              $output.puts "exit."
              exit
            end

            command_request = split_args(line)

            execute(command_request)

          rescue Interrupt
            $output.puts "Interrupted."

          rescue
#            $output.puts "msh error: Operation incomplete."
            $output.puts ""
            $@.each_with_index do |e, i|
              if i == 0
                $output.puts [e, ": ", $!].join
              else
                $output.puts ["\tfrom", e].join
              end
            end
          end

        end
      ensure
        save_history
      end
    end

    def execute(args)
      table = Msh::CommandTable::TOP_TABLE

      args.each{ |command_token|
        command_token_sym = command_token.to_sym
        if Hash === table[command_token_sym]
          table = table[command_token_sym]
        elsif Class === table[command_token_sym]
          table[command_token_sym].new.doit(args)
          return
        end
      }
    end

    def non_interactive_run(argv)
      begin
        execute(argv)
      rescue Interrupt
        puts 'Interrupted.'
      end
    end

    private

    def split_args(line)
      command_request = []
      scanner = StringScanner.new(line.strip)

      until scanner.eos?
#        command_token = scanner.scan(/([\"|'])(.+?)\1\s*|([^\s]+)\s*|/).strip
        command_token = scanner.scan(/\A(["'])([^\1]+?)\1\s*|([^\s]+)\s*/).strip

        if command_token =~ /\A(["'])([^\1]+?)\1\z/
          command_request.push command_token.gsub(/\A(["'])([^\1]+?)\1\z/, $2)

        else
          command_request.push command_token
        end
      end
      command_request
    end

    def load_history
      begin
        File.open("#{ENV["HOME"]}/.msh/.msh_history", "r") { |f|
          f.each_line do |line|
            Readline::HISTORY << line.chomp
          end
        }
      rescue
        # nothing to do.
      end
    end

    def save_history
      begin
        File.open("#{ENV["HOME"]}/.msh/.msh_history", "w") { |f|
          f.puts Readline::HISTORY.to_a
        }
      rescue
        # nothing to do.
      end
    end

  end
end
