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
  lc = 0
  cases = []
  File.open(filename) do |file| 
    test_count = file.readline
    acase = []
    file.each_line do |line|
      if lc % 2 == 0 && line =~ /(\d+)\s(\d+)$/
        acase << $1.to_i
        acase << $2.to_i
      elsif lc % 2 == 1
        
        acase = acase + line.split(" ").map { |it| it.to_i }
        cases << acase
        acase = []
      else
      end
      lc += 1
    end

    
  end
  
  #puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def walk(mymote, motes)
  m = mymote
  index = 0
  puts "walk: #{mymote}, #{motes}"
  motes.each do |am|
    if m > am
      m += am
      puts "swallow m: #{m}, am:#{am}" 
      index += 1      
    end
    
  end
  
  result = []
  result << m
  result << motes[index,motes.length-index]
  
  puts "walk: #{result}"
  
  result
end


def get_req_adds(m,o)
  puts "#{m}, #{o}"
  if (m == 1)
    1
  elsif (m > o)
    0
  elsif (m==o)
    1
  else
    1 + get_req_adds(m+m-1, o)
  end
end

def process(data)
  result = []
  
  steps = 0
  cn = 1
  data.each do |di|
    puts "case ##{cn}"
    cn += 1
    steps = 0
    mymote = di[0]
    mcount = di[1]
    motes = di[2,di.length-2].sort {|a, b| a <=> b }
    
    continue = true
    if (mymote == 1)
      continue = false
      steps = motes.length
    end
    
    # result << walk2(mymote, motes)

    
    while (continue)
      wr = walk(mymote, motes)
      mymote = wr[0]
      motes = wr[1]
      if motes.length > 0
        if (motes.length == 1)
          steps += 1
          continue = false
        else
          nm = motes[0]
          
          how_many_adds = get_req_adds(mymote, nm)
          
          
          if (how_many_adds < motes.length)
            motes = motes.unshift(mymote-1)
            puts "hma: #{how_many_adds}, us motes: #{motes}"
          else
            motes.shift
            puts "s motes: #{motes}"
          end
          
          
          steps += 1
        end
      else
        continue = false
      end
      
      #if steps > 
      #  break
      #end
    end
    
    puts "done stepping: #{steps}"

    result << steps
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

