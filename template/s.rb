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
    result = Dir.glob(glob)[0]
  end
  abort("Input file #{result ? result : glob} not found.") unless result && File.exist?(result)
  
  result
end

def write_output_line(i, data)
  "Case ##{i}: #{data}"
end

def write_output_file(filename, data)
  File.open(filename, 'w') do |file|
    data.each_with_index do |a_case, i|
      file.puts(write_output_line(i+1, a_case))
    end
  end
end

def read_input_file(filename)
  cases = []
  File.open(filename) do |file| 
    test_count = file.readline.chomp.to_i
    file.each_line do |line|
      cases << case_from_input_line(line.chomp)
    end
    puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  end
  
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

if ARGV[0]
  inFilename = input_exists(ARGV[0])
  outFilename = inFilename.sub("\.in", ".out")
  puts "Reading from: #{inFilename}, writing to #{outFilename}"
  cases = read_input_file(inFilename)
  processed_data = process(cases)
  write_output_file(outFilename, processed_data)
else
  puts "Please specify input file"
end
