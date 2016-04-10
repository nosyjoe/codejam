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
      cases << line.split(/\s/).map {|v| v.to_i}
    end
    i += 1
  end
  
  puts "warning: incorrect test case count" if test_count != cases.length 
  # p cases
  cases
end

def process(data)
  result = []
  oner = ""
  i = 1
  data.each do |di|
    x = di[0]
    r = di[1]
    c = di[2]
    shortestside = [r,c].min
    longestside = [r,c].max
    mult = r*c
    shortsidemax = Math.sqrt(x).ceil
    
    puts "case #{i}"
    if x == 1
      puts "bla0"
      oner = "GABRIEL"
    elsif x > longestside
      puts "bla1"
      oner = "RICHARD"
    elsif mult % x != 0
      puts "bla2"
      oner = "RICHARD"
    elsif shortsidemax > shortestside
      puts "bla3"
      oner = "RICHARD"
    elsif x == 4 and shortestside == 2 and longestside > shortestside
      puts "bla4"
      oner = "RICHARD"
    else
      puts "bla5"
      oner = "GABRIEL"
    end
    
    i = i + 1
    result << oner
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

