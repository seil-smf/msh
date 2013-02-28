# -*- coding: utf-8 -*-

# add "lib" directory to load path
$:.unshift(File.join(File.dirname(File.expand_path(__FILE__)), "lib"))

require 'pp'
require 'find'
require 'open-uri'
require 'yaml'

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'colorize'

require 'msh/version'
require 'msh/color'
include Msh::Color

CLEAN.include("*.gem")

desc 'Builds the gem'
task :build do
  sh "gem build msh.gemspec"
end

Rake::TestTask.new(:test) do |test|
  test.libs << 'test' << 'lib'
  test.pattern = 'test/**/test_*.rb'
end

# Document output
require 'yard'
require 'yard/rake/yardoc_task'
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', 'lib/msh/help/help*']
  t.options = []
  t.options << '--debug' << '--verbose' if $trace
end

def confirm(msg)
  while(true)
    puts msg
    yn = $stdin.gets
    yn.chomp!

    break if yn =~ /[yYnN]/
  end

  return yn =~ /[yY]/
end

def get_version
  Msh::VERSION
end

def bump_version(field=:major) # :major, :minor, or :patch
  # update msh/version.rb

  puts "Current Version: " + notice(`rake version:show:thisdir`.chomp!)

  path = File.join(File.dirname(File.expand_path(__FILE__)), "lib", "msh", "version.rb")
  f = File.open(path, "r+")
  code = f.read
  f.close

  const = "VERSION_" + field.to_s.upcase
  next_version = eval("Msh::" + const) + 1

  code.gsub!(/#{const} = \d+/, "#{const} = #{next_version}")

  f = File.open(path, "w")
  f.write(code)
  f.close

  puts "Bumped  Version: " + important(`rake version:show:thisdir`.chomp!)
end

namespace :version do
  namespace :show do
    desc 'show the version of this directory'
    task :thisdir do
      puts important(get_version)
    end
  end

  namespace :bump do
    desc 'bump major version (ex: 1.y.z to 2.y.z)'
    task :major do
      bump_version(:major)
    end

    desc 'bump minor version (ex: x.1.z to x.2.z)'
    task :minor do
      bump_version(:minor)
    end

    desc 'bump patch level (ex: x.y.0 to x.y.1)'
    task :patch do
      bump_version(:patch)
    end

  end
end

task :default => [:test, :build]
