#!/usr/bin/ruby

prog = ARGV[0]
current_dir = ARGV[1]
Dir.chdir current_dir
dir = 'tmp'
Dir.mkdir dir unless Dir.exists? dir
temp_file = "./tmp/last_output"
divider =  "--------------------------------------------------"
files = Dir["./tests/*.in"]
total = files.size
succeded = 0
failed = 0


puts <<START 
Running tests for
#{current_dir}
#{divider}
START
files.each.with_index do |file,i|
  `./#{prog} < #{file} > #{temp_file}`
  out_file = file.split('.')[0..-2].join(".")+".out"
  input = File.open(file).read
  expected = File.open(out_file).read
  got = File.open(temp_file).read
  print "#{i+1}) "
  if (got == expected)
    succeded += 1
    puts "OK"
  else
    failed += 1
    puts <<ERROR
Got error:
On input:
#{input}
  expected:
#{expected}
  but got:
#{got}
ERROR
  end
  puts divider
end

puts <<RES
Results:
total: #{total}
succeded: #{succeded}
failed: #{failed}
RES
if failed == 0
  puts "All tests passed successfully!"
else
  puts "GOT SOME ERRORS!"
end
