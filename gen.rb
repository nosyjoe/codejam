#!/usr/bin/env ruby
require 'date'
require 'fileutils'

def copy_files(folder)
  ["a", "b", "c", "d"].each do |problem|
    FileUtils.cp_r "template", "#{folder}/#{problem}", :verbose => false
  end
end

what = ARGV[0]
year = ARGV[1] || Date.today.year.to_s
target = nil

case what
when /q|qualification/
  puts "Generating qualification for year #{year}"
  target = 'qualification'
when /r(\d)|round(\d)/
  puts "Generating round#{$1} for year #{year}"
  target = "round#{$1}"
else
  puts "Don't know how to generate #{what}"
end

folder = "./#{year}/#{target}"
if !File.exist?(folder)
  Dir.mkdir(year) unless File.exist?(year)
  Dir.mkdir(folder)
  copy_files(folder)
else
  puts "Target directory #{folder} already exists, aborting."
end
