#!/usr/bin/ruby
# How to use:
#   ruby  fetch_tests C P
#   where C - number of a contest
#         P - problem ID (A,B,C,D,E)

require 'nokogiri'
require 'open-uri'

def fetch_tests(contest, problem)
  raise "File: #{__FILE__}, line: #{__LINE__}" unless contest && problem

  dir = "./#{problem}/tests/"
  test_file = "test"
  Dir.mkdir dir unless Dir.exists? dir

  doc = Nokogiri::HTML(open("http://codeforces.ru/contest/#{contest}/problem/#{problem}"))
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
end
