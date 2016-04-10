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
  test_count = 0
  cases = []
  File.open(filename) do |file| 
    test_count = file.readline.strip.to_i
    (1..test_count).each do |l|
      cases << file.readline.strip.split(/\s/).map {|c| c.to_i}
    end  
    i += 1
  end
  
  puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def generate(r,c,m,n)
  
  field = "\n"
  
  puts "#{r} #{c} #{r*c} #{m} #{n}"
  
  ncount = n
  count = n
  nc = 0
  nr = 0
  
  if ncount.modulo(r) != 1
    nr = r
    nc = ncount / r + ncount.modulo(r)
  elsif ncount.modulo(c) != 1
    nc = c
    nr = ncount / c + ncount.modulo(c)
  else
    puts 'blorg'
  end
  
  
  (0...r).each do |ri|
      #row = []
      (0...c).each do |ci|
        if ci == 0 && ri == 0
          field = field + 'c'
        elsif (ri < nr && ci < nc) 
          if count > 0
            if count == 1 && ( (ci == 0) || (ci == nc - 2))
              return nil
            end
            field = field +  '.'
            count = count - 1
          else
            field = field +  '*'
          end
        else
          field = field + '*'
        end
      end
      field = field + "\n"
    end
  
  field
end

# def generate(r,c,m,n) 
#   # count = n-1
#   # root = Math.sqrt(n).round
#   # nr = root
#   # nc = root
#   
#   
#   # field = "\n"
#   
#   puts "#{r} #{c} #{r*c} #{m} #{n}"
#   # p nc
#   # p nr
#   # p 0...c
#     
#     
#   field = []
#   (0...r).each do |ri|
#     row = []
#     (0...c).each do |ci|
#       row << ' '
#     end
#     field << row
#   end
#   
#   # p field
#   
#   ci = 0
#   ri = 0
#   i = 0
#   
#   mcount = m
#   while (ci <= c && ri <= r) do
#     # if mcount > 0
# #       if ri == 0 && ci == 0
# #         field[ri][ci] = '*'
# #         
# #       else
# #         
# #       end
# #     else
# #     end
#     
# if ri == field.length || ci == field[ri].length
#   next
# end
#     
# field[ri][ci] = i
#     
#     if (ci == 0)
#       ci = ri+1
#       ri = 0
#     else
#       ci = ci - 1
#       ri = ri + 1
#     end
#     
#     i = i +1
#   end
#   
#   p field
#    puts
#   
#   field
# end


# def generate(r,c,m,n) 
#   count = n-1
#   root = Math.sqrt(n).round
#   nr = root
#   nc = root
#   
#   if nr > r
#     nc = nc + (nr - r)
#     nr = r
#   end
#   
#   if nc > c
#     nr = nr + (nc - c)
#     nc = c
#   end
#   
#   if (nc*nr < n)
#     if (nr < r)
#       nr = nr + 1
#     else
#       nc = nc + 1
#     end
#   end
#   
#   
#   field = "\n"
#   
#   # puts "#{r} #{c} #{r*c} #{m} #{n}"
#   # p nc
#   # p nr
#   # p 0...c
#     
#   (0...r).each do |ri|
#     #row = []
#     (0...c).each do |ci|
#       if ci == 0 && ri == 0
#         field = field + 'c'
#       elsif (ri < nr && ci < nc) 
#         if count > 0
#           if count == 1 && ( (ci == 0) || (ci == nc - 2))
#             return nil
#           end
#           field = field +  '.'
#           count = count - 1
#         else
#           field = field +  '*'
#         end
#       else
#         field = field + '*'
#       end
#     end
#     field = field + "\n"
#   end
#   
#   # puts field
#   # puts
#   
#   field
# end

def process(data)
  result = []
  i = 1
  
  data.each do |di|
    r = di[0]
    c = di[1]
    m = di[2]
    n = r*c - m
    
    
    works = false
    if n == 2 || n == 3
      puts "#{i}: n: #{n}"
      works = r == 1 || c == 1
    elsif n == 1
      # puts "#{i}: n: #{n}"
      works = true
    else
      if (r == 3 && c == 2 && m == 1) || (r == 2 && c == 3 && m == 1)
        p di
        works = false
      else
        works = true
      end
      # generate solution
    end
    
    field = nil
    if works
      field = generate(r,c,m,n)
    end  
    
    if field
      result << field
    else
      result << "\nImpossible"
    end
    
    puts i
    
    i = i + 1
    #puts "#{r*c} #{m} #{n}: #{works}"
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

