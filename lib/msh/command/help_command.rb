# -*- coding: utf-8 -*-

require 'msh/command/abstract_command'

module Msh
  module Command
    class HelpCommand < AbstractCommand
      def doit(command_array)
        print_help(command_array.clone)
      end

      private

      # command を Array を引数にして該当するヘルプを表示します
      def print_help(command)
        path = search_help_path(command)
        if path.nil? then
          $output.puts "Can not find the help for the command"
        else
          print_text(path)
        end
      end

      # helpファイルの絶対パスを返却します。見つからない場合は nilを返却します。
      def search_help_path(command)
        # helpファイルの相対パスを生成 (mshモジュールがあるディレクトリの位置から)
        base_dir = "/msh/help/"
        help_file_path = base_dir.clone
        # help_xxx_xxx という文字列を生成
        command.each{|c|
          help_file_path.concat(help_file_path == base_dir ? "#{c}" : "_#{c}")
        }

        # module のパスからヘルプファイルを探して返却する
        $LOAD_PATH.each{|s|
          if File.exist?(s + help_file_path) then
            return s + help_file_path
          end
        }

        return nil
      end

      def print_text(path)
        IO.foreach(path){|s|
          $output.puts s
        }
      end
    end
  end
end

