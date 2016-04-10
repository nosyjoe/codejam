#!/usr/bin/env ruby -wKU

class Attack
  attr_reader :date, :west, :east, :strength
  
  def initialize(date,west,east,strength)
    @date = date
    @west = west
    @east = east
    @strength = strength
  end
  
  def to_s
    "A(#{@date},#{@west},#{@east},#{strength})"
  end
end

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
  acase = []
  File.open(filename) do |file| 
    test_count = file.readline
    file.readline
    file.each_line do |line|
      v = line.split("\s")
      if (v.length < 2)
        cases << acase
        acase = []
      else
        tribe = v.map {|av| av.to_i}
        start = tribe[0]
        nr = tribe[1]
        west = tribe[2]
        east = tribe[3]
        str = tribe[4]
        deltadate = tribe[5]
        deltadist = tribe[6]
        deltastr = tribe[7]
  
        (0...nr).each do |i|
          date = start + i*deltadate
          an_attack = Attack.new(date, west+i*deltadist, east+i*deltadist, str+i*deltastr)
          acase << an_attack
        end
      end
    end
  end
  
  #puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def process(data)
  result = []
  
  data.each do |di|
    puts "attacks: #{di.length}"
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

