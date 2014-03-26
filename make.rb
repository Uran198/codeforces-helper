#!/usr/bin/ruby

dir = ARGV[0]
problems = 'A'..'E'
files = ["fetch_tests.rb", "run_tests.rb", "Makefile", "main.cpp"]
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
  Dir.chdir path do
    `ruby fetch_tests.rb #{dir} #{x}`
  end
end

mains.join(" ")
`vim --cmd "set autochdir" -- #{mains}`
