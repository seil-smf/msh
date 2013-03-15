
require 'pp'
require 'awesome_print'
require 'colorize'
require 'msh/msh'

module Msh

  def self.start(argv)
    if RUBY_VERSION >= '1.9'
      shell = Msh::Cli.new
      if argv.empty?
        shell.run
      else
        if idx = argv.index("user_code")
          argv.delete_at(idx)
          $conf[:user_code] = argv.delete_at(idx)
        end
        shell.non_interactive_run(argv)
      end
    else
      $stderr.puts "Ruby version 1.9.* is required to run msh."
    end

  end
end
