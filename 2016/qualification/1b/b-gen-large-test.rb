#!/usr/bin/env ruby -wKU

puts "100"
(0...100).each do |i| 
  puts (0...Random.rand(100)).inject('') do |sum, n| 
    sum += Random.rand(2) == 1 ? '+' : '-'
  end
end