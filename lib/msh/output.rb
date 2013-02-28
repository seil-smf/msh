require 'stringio'

module Msh
  module Output
    def self.create(conf)
      case conf[:output]
      when "stderr"
        return Msh::Output::Stderr.new(conf)
      when "stdout"
        return Msh::Output::Stdout.new(conf)
      when "null"
        return Msh::Output::Null.new(conf)
      when "file"
        return Msh::Output::File.new(conf)
      when "buffer"
        return Msh::Output::Buffer.new(conf)
      else
        return Msh::Output::Stdout.new(conf)
      end
    end

    class Stderr
      def initialize(options={})
        # do nothing
      end

      def puts(msg)
        $stderr.puts(msg)
      end

      def print(msg)
        $stderr.print(msg)
      end
    end

    class Stdout
      def initialize(options={})
        # do nothing
      end

      def puts(msg)
        $stdout.puts(msg)
      end

      def print(msg)
        $stdout.print(msg)
      end
    end

    class Null
      def initialize(options={})
        # do nothing
      end

      def puts(msg)
        # do nothing
      end

      def print(msg)
        # do nothing
      end
    end

    class Buffer
      def initialize(options={})
        @buffer = ""
      end

      def puts(msg)
        @buffer += msg + "\n"
      end

      def print(msg)
        # do nothing
      end

      def buffer
        @buffer.to_s
      end

      def clear
        @buffer = ""
      end
    end

    class File
      def initialize(options)
        @filename = options[:output_file]
        @file = ::File.open(@filename, "a+")
      end

      def print(msg)
        # do nothing
      end

      def puts(msg)
        @file.puts(msg)
      end
    end
  end
end
