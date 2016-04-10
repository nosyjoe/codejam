#!/usr/bin/env ruby -wKU

require 'prime'

def write_output_line(i, data)
  "Case ##{i}: #{data}"
end

def write_output_file(filename, data)
  i = 1
  File.open(filename, 'w') do |file|
    data.each do |a_case|
      file.puts(write_output_line(i, a_case))
      i += 1
    end
  end
end

def read_input_file(filename)
  test_count = 0
  cases = []
  File.open(filename) do |file| 
    test_count = file.readline.chomp.to_i
    file.each_line do |line|
      cases << case_from_input_line(line.chomp)
    end
  end
  
  puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def process(data)
  data.inject([]) do |acc, di| 
    acc << process_case(acc.length, di) 
  end
end

def case_from_input_line(line)
  line.chomp.split(/ /).map {|s| s.to_i }
end

def gen_coin(l)
  middle = (0...l-2).inject([]) do |acc, n| 
    acc << Random.rand(2)
  end
  [1] + middle + [1]
end

def number_for_base(base, coin)
  coin.reverse.each.with_index.inject(0) do |sum, (digit, i) |
    # puts "#{digit} * #{base ** i}"
    sum += digit * (base ** i)
  end
end

def process_case(i, data)
  result = "\n"
  
  n = data[0]
  j = data[1]
  
  coins = {}
  
  i = 0
  while coins.length < j
    c = gen_coin(n)
    # p c
    any_prime = (2..10).any? do |base|
      # puts "number #{number_for_base(base, c)}, base: #{base}"
      r = Prime.prime?(number_for_base(base, c))
      # puts "is prime #{base}: #{r}"
      r
    end
    
    i += 1
    next unless !any_prime
    
    
    dividers = (2..10).inject([]) do |acc, base|
      acc << Prime.prime_division(number_for_base(base, c))[0][0]
    end
    
    nr_10 = number_for_base(10, c)
    p nr_10
    coins[nr_10] = "#{nr_10} #{dividers.join(" ")}"
  end
  
  result + coins.values.join("\n")
end

inFilename = ARGV[0]

if inFilename 
  outFilename = inFilename.sub("\.in", ".out")

  cases = read_input_file(inFilename)
  p cases
  processed_data = process(cases)
  p processed_data
  write_output_file(outFilename, processed_data)

else
  puts "Please specify input file"
end

