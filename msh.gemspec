# -*- coding: utf-8 -*-

# add "lib" directory to load path
$:.unshift(File.join(File.dirname(File.expand_path(__FILE__)), "lib"))

require 'msh/version'

Gem::Specification.new do |s|
  s.name = "msh"
  s.version = Msh::VERSION
  s.date = Time.now

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency('colorize')
  s.add_dependency('awesome_print')

  s.homepage = "http://manual.sacm.jp/cli/index.html"
  s.author = "Internet Initiative Japan Inc."
  s.summary = "msh - a SACM Shell"

  s.files = Dir["lib/**/*.rb"] + Dir["bin/*"] + Dir["lib/msh/help/help*"]
  s.files.reject! { |fn| fn.include?('.svn') || fn.include?('.git') || fn.include?('~') }
  s.bindir = 'bin'
  s.has_rdoc = false
  s.require_paths = ["lib"]
  s.executables = Dir["bin/*"].map { |fp| fp.split("/")[1] }
end
