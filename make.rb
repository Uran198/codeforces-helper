#!/usr/bin/ruby

dir = ARGV[0]
problems = 'A'..'E'
files = ["fetch_tests.rb", "run_tests.rb", "Makefile", "main.cpp"]
cur = Dir.pwd
files.map! { |x| x = cur+'/lib/'+x}

Dir.mkdir dir unless Dir.exists? dir
Dir.chdir dir do
  files[0..1].each { |file| `cp #{file} . `}
  problems.each do |x|
    Dir.mkdir x unless Dir.exists? x
  end
end

mains = []

problems.each do |x|
  path = dir+'/'+x+'/'
  mains << (path + "main.cpp")
  files[-2..-1].each { |file| `cp #{file} #{path}` }
  Dir.chdir dir do
    `ruby fetch_tests.rb #{dir} #{x}`
  end
end

exec 'vim --cmd "set autochdir" ' + mains.join(" ")

