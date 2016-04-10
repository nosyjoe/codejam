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
      v = line.split("\s")
      cases << [v[0],v[1].to_i]
    end
    i += 1
  end
  
  #puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end


CONS = ['b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','y','z']
CONSRE = /[bcdfghjklmnpqrstvwxyz]/

def find(word, s,e,n)
  if word[s,e] =~ /[bcdfghjklmnpqrstvwxyz]{n}/
    return 1 + find(word, s, )
  else
  end
end

# def count(word, index, n) 
#   result = 0
#   l = n
#   s = index
#   e = index+l
#   
#   while (s >= 0)
#     while (e <= word.length)
#       puts "#{s} #{e} #{l}"
#       result +=1
#       e += 1
#     end
#     e=index+l
#     s = s-1
#   end
#   
#   puts ""
#   
#   result
# end

def count(word, index, n) 
  result = []
  l = n
  s = index
  e = index+l
  sub = word[index,l]
  
  while (s >= 0)
    while (e <= word.length)
      # puts "#{s} #{e} #{l}"
      result << "#{s},#{e}"
      e += 1
    end
    e=index+l
    s = s-1
  end
  
  # puts ""
  
  result
end


def find_indices(word, str)
  result =[]
  s = word
  while (s && i = s.index(str))
    result << i
    s = s[i+str.length]
  end
  
  result
end


def find_nstreak(word, n)
  result = []
  l = word.length
  s = 0
  i = 0
  
  while (i <l-n+1)
    sub = word[i,n]
    # puts "#{sub}"
    if (sub =~ /[bcdfghjklmnpqrstvwxyz]/)
      result << [i, sub]
    end
      
    i += 1
  end
  
  
  result
end

OBJ = Object.new

def process(data)
  result = []
  
  data.each do |di|
    word = di[0]
    n = di[1]
    nvalue = 0
        
    #matches = word.scan(/[bcdfghjklmnpqrstvwxyz]{#{n}}/)
    # positions = word.enum_for(:scan, /[bcdfghjklmnpqrstvwxyz]{#{n}}/).map { Regexp.last_match.begin(0) }
    
    #matches + find_doubles(word, matches, n)
    matches = find_nstreak(word, n)
    
    # puts "#{matches}"
    
    temp = {}
    
    matches.each do |m|
      ids = count(word, m[0], n)
      ids.each do |id|
        # puts "id: #{id}"
        temp[id] = OBJ
      end
      
    end
    
    # puts "#{positions}"
#     positions.each do |index|
#       nvalue += count(word, index, n)
#     end
      
      
     result << temp.length
    # result << nvalue
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

