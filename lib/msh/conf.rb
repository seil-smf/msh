# -*- coding: utf-8 -*-

require "fileutils"

module Msh
  class Conf < Hash
    MSHRC_DIR_PATH = "#{ENV["HOME"]}/.msh"
    def initialize(filename="#{MSHRC_DIR_PATH}/mshrc")
      @filename = filename
      unless File.exist?(@filename)
        $stderr.puts '"mshrc" Not found. Please make sure "mshrc" exists in "~/.msh/" directory.'
      end

      begin
        unless Dir.exist?(MSHRC_DIR_PATH)
          Dir.mkdir(MSHRC_DIR_PATH)
        end
      rescue => e
        p e
      end

    end

    def read
      self.clear
      if File.exist?(@filename)
        File.open(@filename, "r") { |f|
          f.each_line { |line|
            next if line !~ /.*:.*/
            next if line =~ /^#.*/
            sep_line = line.split(':')
            self[sep_line[0].strip.to_sym] = sep_line[1].strip!
          }
        }
      end

      self
    end

    def set_mshrc(filename)
      @filename = filename
    end

    def puts_conf
        self.each{|k,v|
          $output.puts "#{k} : #{v}"
        }
    end
  end
end
