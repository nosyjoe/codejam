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
  i = 1
  cases = []
  File.open(filename) do |file| 
    test_count = file.readline
    file.each_line do |line|
      if line =~ /(\d+)\s+(\d+)\s+(\d+)/
        acase = []
        acase << $1.to_i
        acase << $2.to_i
        acase << $3.to_i
        cases << acase
      end
    end
    i += 1
  end
  
  #puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def process(data)
  result = []
  
  data.each do |di|
    result << di
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

