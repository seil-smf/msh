require 'pp'
require 'awesome_print'
require 'colorize'

require 'msh/msh'

module Msh
  def self.start(argv)
    if RUBY_VERSION < '1.9'
      $stderr.puts "Ruby version 1.9.* is required to run msh."
      exit 1
    end

    shell = Msh::Cli.new

    parse_args(argv)

    if argv.empty?
      # invoke msh as interactive mode
      shell.run
    else
      # invoke msh as non-interactive mode
      shell.non_interactive_run(argv)
    end
  end

  def self.parse_args(argv)
    if idx = argv.index("--mshrc")
      argv.delete_at(idx)
      $conf.set_mshrc(argv.delete_at(idx))
      begin
        $conf.read
      rescue => e
        p e
      end
    end

    if idx = argv.index("user_code")
      argv.delete_at(idx)
      $conf[:user_code] = argv.delete_at(idx)
    end
  end

end
