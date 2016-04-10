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
  line.split(/ /).map {|s| s.to_i }
end

def process_case(i, data)
  k = data[0]
  c = data[1]
  s = data[2]
  (1..k).to_a.join(" ")
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

