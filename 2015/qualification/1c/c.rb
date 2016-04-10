#!/usr/bin/env ruby -wKU

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
  i = 0
  cases = []
  File.open(filename) do |file| 
    test_count = file.readline.to_i
    file.each_line do |line|
      d = 0
      if i % 2 == 0
        d = line.to_i
      else
        cases << [d, line.split(/\s/).map {|v| v.to_i}]
      end
      i = i+1
    end
    
    
    
  end
  p cases
  p test_count
  
  puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def best_time(pancakes, level)
  pancakes.sort.reverse
  highest_stack = pancakes[0]
  rest = pancakes[1,pancakes.length-1]
  if level < 9
      sols = [highest_stack]
      half_stack = highest_stack/2
      (1..half_stack).each do |i|
        sols << (best_time(rest + [highest_stack - i, i], level + 1) + 1)
      end
      sols.sort
      sols[0]
  else
    highest_stack
  end
end

def process(data)
  result = []
  
  data.each do |di|
    eaters = di[1]
    result << best_time(eaters, 0)
  end
  # do something here
  
  result
end

inFilename = ARGV[0]

if inFilename 
  outFilename = inFilename.sub("\.in", ".out")

  cases = read_input_file(inFilename)
  processed_data = process(cases)
  write_output_file(outFilename, processed_data)

else
  puts "Please specify input file"
end

