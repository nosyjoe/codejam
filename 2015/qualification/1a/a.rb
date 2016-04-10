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
  i = 1
  cases = []
  File.open(filename) do |file| 
    test_count = file.readline.to_i
    file.each_line do |line|
      splitted = line.split(/\s/)
      acase = splitted[1].split(//).map {|c| c.to_i }
      cases << acase
    end
    i += 1
  end
  
  p cases
  
  puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def process(data)
  result = []
  
  data.each do |di|
    shyness = 0
    friends = 0
    sum = 0
    
    di.each do |am|
      if shyness > 0
        delta = shyness - sum
        if delta > 0
          friends = friends + delta
          sum = sum + delta
        end
      end
      
      sum = sum + am
      shyness = shyness + 1
    end
    
    result << friends
  end
  
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

