#!/usr/bin/env ruby -wU

def input_exists(filename)
  result = filename
  # shortcut to input files
  glob = nil
  if filename =~ /t/
    glob = '*-test.in'
  elsif filename =~ /s(\d)?/
    glob = "*-small-attempt#{$1 ? $1 : 0}.in"
  elsif filename =~ /l/
    glob = "*-large.in"
  end
  if glob
    result = Dir.glob("*-large.in")[0]
  end
  abort("Input file #{result ? result : glob} not found.") unless result && File.exist?(result)
  
  result
end

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
  # process single line from the input file.
  line
end

def process_case(i, data)
  # process the input and return valid output as specified in the problem description
  data
end

inFilename = ARGV[0]

if inFilename
  inFilename = input_exists(inFilename)
  
  outFilename = inFilename.sub("\.in", ".out")
  puts "Reading from: #{inFilename}, writing to #{outFilename}"

  cases = read_input_file(inFilename)
  # p cases
  processed_data = process(cases)
  # p processed_data
  write_output_file(outFilename, processed_data)
else
  puts "Please specify input file"
end

