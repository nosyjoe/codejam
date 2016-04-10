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

def read_case(file)
  result = nil
  
  begin
    result = []
    result << file.readline.strip.to_i
    (1..4).each { |i| result << file.readline.strip.split(/\s/).map { |c| c.to_i} }
    result << file.readline.strip.to_i
    (1..4).each do |i|
      result << file.readline.strip.split(/\s/).map { |c| c.to_i}
    end
  rescue
    result = nil
  end
  
  result
end

def read_input_file(filename)
  i = 1
  cases = []
  test_count = -1
  File.open(filename) do |file| 
    test_count = file.readline.strip.to_i
    begin
      a_case = read_case(file)
      if a_case
        cases << a_case
      end
    end while a_case
    i += 1
  end
  
  puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  #p cases
  cases
end

def process(data)
  result = []
  
  data.each do |di|
    first = di.slice(0,5)
    second = di.slice(5,5)
    
    row1 = first[first[0]]
    row2 = second[second[0]]
    answer = row1 & row2
    
    if answer.size == 1
      result << answer[0].to_s
    elsif answer.size > 1
      result << 'Bad magician!'
    else
      result << 'Volunteer cheated!'
    end
    
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

