#!/usr/bin/ruby

# How to use:
#   execute with command
#   ruby make.rb N [X]
#   N is a number of contest
#   X name of a problem, maybe multiple, default are A..E
#
require_relative 'lib/fetch_tests.rb'

if ARGV.size < 1 || ARGV[0] == "--help"
  puts <<STR
Using:
  make.rb cont [prob]
  Where cont is number of contest,
  prob is number of problem(if not specified takes all)
  -- help - display this massage
STR
  exit
end

dir = ARGV[0]
problems = ARGV.size == 1 ? 'A'..'E' : ARGV[1..-1]
files = ["Makefile", "main.cpp"]
cur = Dir.pwd
files.map! { |x| x = cur+'/lib/'+x}

Dir.mkdir dir unless Dir.exists? dir
Dir.chdir dir do
  problems.each do |x|
    Dir.mkdir x unless Dir.exists? x
  end
end

mains = []

problems.each do |x|
  path = dir+'/'+x+'/'
  mains << (path + "main.cpp")
  files.each { |file| `cp #{file} #{path}` }
  Dir.chdir dir do
    fetch_tests(dir, x)
  end
end

exec 'vim +16 --cmd "set autochdir" ' + mains.join(" ")

