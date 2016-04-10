#!/usr/bin/env ruby -wKU

def is_palindrome(number)
  nrstr = number.to_s
  l = nrstr.length
  
  if l.modulo(2) == 0
    # even length
    half1 = nrstr.slice(0, l/2)
    half2 = nrstr.slice(l/2,l)
  else
    half1 = nrstr.slice(0, l/2)
    half2 = nrstr.slice(l/2+1,l)
  end
  
  half1 == half2.reverse
end

def get_pal_count(precalculated, first, last) 
  start_root = Math.sqrt(first.to_i).ceil
  end_root = Math.sqrt(last).floor
  range = start_root..end_root
  result = 0
  range.each do |one_root|
    if is_palindrome(one_root) && is_palindrome(one_root*one_root)
      result += 1
      puts "squaire and fair palindrome #{one_root*one_root} (root: #{one_root})"
    end
  end
  
  result
end


def read_input_file(filename)
  i = 1
  cases = []
  File.open(filename).each_line do |line| 
    if line =~ /^(\d+)/
      test_count = $1.to_i
    elsif line =~ /^(\d+)\s+(\d+)$/
      cases << [$1, $2]
    end 
    i += 1
  end
end

#input = read_input_file(ARGV[0])

pre = []

count = get_pal_count(1, 10)
puts "count: #{count}"

count = get_pal_count(10, 120)
puts "count: #{count}"

count = get_pal_count(100, 1000)
puts "count: #{count}"

#count = get_pal_count(34, 1E40)
puts "count: #{count}"
