#!/usr/bin/env ruby -wKU

def get_next_palindrome(number)
  nrstr = number.to_s
  l = nrstr.length
  half_l = l/2
  
  if l.modulo(2) == 0
    # even length
    half1 = nrstr.slice(0, half_l)
    half2 = nrstr.slice(l/2,l)
    if half1 == half2.reverse
      half1 = (half1.to_i + 1).to_s
      if (half1.length > half2.length)
        return get_next_palindrome(("1"+"0"*half2.length*2).to_i)
      end
    end
    
    (half1+half1.reverse).to_i
  else
    half1 = nrstr.slice(0, half_l)
    middle = nrstr.slice(half_l,1)
    half2 = nrstr.slice(half_l+1,l)
    if half1 == half2.reverse
      middle_as_i = middle.to_i
      if middle_as_i < 9
        middle = (middle_as_i+1).to_s
      else
        middle = "0"
        half1 = (half1.to_i + 1).to_s
        if (half1.length > half2.length)
          return get_next_palindrome(("10"+"0"*half2.length*2).to_i)
        end
      end
    end
    
    (half1+middle+half1.reverse).to_i
  end
end

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

def get_pal_count(first, last) 
  #puts "NEW INTERVAL: #{first} - #{last}"
  start_root = Math.sqrt(first.to_i).ceil
  end_root = Math.sqrt(last).floor
  #puts "NEW INTERVAL: #{start_root} - #{end_root}"
  result = 0
  current_pal = start_root
  
  while current_pal <= end_root
    square_pal = current_pal*current_pal
    #puts "new root pal: #{current_pal}"
    #puts "new fs: #{square_pal} (root: #{current_pal})"
    if is_palindrome(square_pal) && square_pal <= last
      #puts "new fs: #{square_pal} (root: #{current_pal})"
      result += 1
    end
    current_pal = get_next_palindrome(current_pal)
  end
  
  result
end

def get_pal_count_from_precalculated(first, last, pre)
  result = 0
  pre.each do |val|
    if (val >= first && val <= last)
      result += 1
    end
  end
  
  result
end

def get_pals(last) 
  start_root = 1
  end_root = Math.sqrt(last).floor
  result = []
  current_pal = start_root
  
  while current_pal <= end_root
    square_pal = current_pal*current_pal
    #puts "new root pal: #{current_pal}"
    #puts "new fs: #{square_pal} (root: #{current_pal})"
    if is_palindrome(square_pal) && square_pal <= last
      puts "new fs: #{square_pal} (root: #{current_pal})"
      result << square_pal
    end
    current_pal = get_next_palindrome(current_pal)
  end
  
  result
end



def read_input_file(filename)
  i = 1
  cases = []
  File.open(filename).each_line do |line| 
    if line =~ /^(\d+)$/
      test_count = $1.to_i
    elsif line =~ /(\d+)\s+(\d+)/
      cases << [$1.to_i, $2.to_i]
    end 
    i += 1
  end
  
  puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

fpals = get_pals(1E24)

input = read_input_file(ARGV[0])

#puts "#{ARGV[0]}: #{input.inspect}"

i = 1
input.each do |a_case|
  #count = get_pal_count(a_case[0], a_case[1], fpals)
  count = get_pal_count_from_precalculated(a_case[0], a_case[1], fpals)
  puts "Case ##{i}: #{count}"
  i += 1
end

