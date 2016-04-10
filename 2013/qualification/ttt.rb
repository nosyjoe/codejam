#!/usr/bin/env ruby -wKU

def get_result(a_case) 
  is_open = a_case.include?(".")
  single_results = []
  
  4.times do |c|
    single_results << check_set(a_case.slice(4*c, 4))
  end
  4.times do |c|
    single_results << check_set(a_case[c,1]+ a_case[4+c,1]+ a_case[8+c,1]+ a_case[12+c,1])
  end
  single_results << check_set(a_case[0,1]+ a_case[5,1]+ a_case[10,1]+ a_case[15,1])
  single_results <<  check_set(a_case[3,1]+ a_case[6,1]+ a_case[9,1]+ a_case[12,1])
  single_results.each do |one_result| 
    if one_result == "X" || one_result == "O"
      return one_result
    end
  end
  if is_open 
    "."
  else
    "D"
  end
end

def check_set(set) 
  counts = count(set)
  if counts["O"] && (counts["O"] == 4 || (counts["O"] == 3 && counts["T"] == 1))
    "O"
  elsif counts["X"] && (counts["X"] == 4 || (counts["X"] == 3 && counts["T"] == 1))
    "X"
  elsif counts["."] 
    "."
  end
end

def count(set) 
  result = Hash.new {|h, k| h[k] = 0}
  set.split("").each do |letter|
    result[letter] += 1
  end
  result
end

input = ARGV[0]

if !input
  puts "Input file missing"
  exit(10);
end

test_count = 0
cases = []
current_case = ""

i = 0

File.open(ARGV[0]).each_line do |line| 
  if line =~ /^(\d+)/
    test_count = $1.to_i
  elsif line =~ /^(([XOT.])([XOT.])([XOT.])([XOT.]))$/
    current_case += $1
  elsif line =~ /^$/
    cases += [current_case]
    current_case = ""
  end 
  i += 1
end

if (cases.length != test_count) 
  puts "ERROR: test count does not match number of tests"
end

i = 1
cases.each do |acase| 
  result = get_result(acase)
  msg = ""
  if result == "X"
    msg = "X won"
  elsif result == "O" 
    msg = "O won"
  elsif result == "D"
    msg = "Draw" 
  else
    msg = "Game has not completed"
  end
  puts "Case ##{i}: #{msg}"
  i += 1
end



