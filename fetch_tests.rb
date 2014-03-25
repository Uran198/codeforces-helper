#!/usr/bin/ruby
require 'nokogiri'
require 'open-uri'

contest = ARGV[0]
dir = "./tests/"
test_file = "test"

doc = Nokogiri::HTML(open("http://codeforces.ru/contest/#{contest}/problem/A"))
# even indexes for input
# odd  indexes for output
data = doc.css('div[class="sample-test"]')[0].css('pre')

data.to_a.each.with_index do |y,i|
  ext = i.even? ? '.in' : '.out'
  num = (i/2 + 1).to_s
  content = y.children.map { |x| x.text }.select { |x| !x.empty? }.join("\n").strip
  path = dir + test_file + num + ext
  file = File.open(path, "w")
  file << content
  file.close
end
