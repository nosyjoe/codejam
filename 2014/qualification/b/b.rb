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
    test_count = file.readline.strip.to_i
    (1..test_count).each do |l|
      cases << file.readline.strip.split(/\s/).map {|c| c.to_f}
    end  
    i += 1
  end
  
  #puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def process(data)
  result = []
  
  j = 1
  data.each do |di|
    c = di[0]
    f = di[1]
    x = di[2]
    
    
    i = 0
    
    time = 1000000000
    nu_time = x/2
    
    while  time - nu_time > 1E-6
      i = i + 1
      time = nu_time
      nu_time = 0
      (0...i).each do |mult|
        nu_time = nu_time + c / (f*(mult)+2)
        # puts "#{mult}" 
      end
      nu_time = nu_time + x / (f*(i)+2)
      
      
      # puts "#{i}: #{time} #{time-nu_time}"
      # puts
    end 
    
    # puts
    
    # p time
    # p nu_time
    
    puts j
    j = j+1
    
    result << time
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

