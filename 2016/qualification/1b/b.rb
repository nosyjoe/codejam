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
    test_count = file.readline.chomp.to_i
    file.each_line do |line|
      cases << case_from_input_line(line.chomp)
    end
    i += 1
  end
  
  puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def process(data)
  result = []
  
  i = 0
  data.each do |di|
    result << process_case(i, di)
    i += 1
  end
  # do something here
  
  result
end

def case_from_input_line(line)
  line.split(//).map { |c| c == "+" ? 1 : 0 }
end

def flip(input)
  input.map {|x| x == 0 ? 1 : 0}.reverse
end

def process_case(i, data)
  d = data
  pt = 0
  result = 0
  
  while pt < d.length
    first = d[0]
    (1..d.length).each do |x|
      pt = x
      if x == d.length || d[x] != first
        break
      end
    end
    
    if pt == d.length
      if first != 1
        d = flip(d)
        result = result+1
        # puts pt
        # p d
      end
    else
      d = flip(d[0, pt]) + d[pt, d.length-1]
      result = result+1
      # puts pt
      # p d
    end
  end
  
  # if d[0] == 0
#     d = flip(d)
#     result = result+1
#     p d
#   end
  
  puts "result (#{i}): #{result}"
  p d
  puts ""
  result
end

inFilename = ARGV[0]

if inFilename 
  outFilename = inFilename.sub("\.in", ".out")

  cases = read_input_file(inFilename)
  p cases
  processed_data = process(cases)
  write_output_file(outFilename, processed_data)

else
  puts "Please specify input file"
end

