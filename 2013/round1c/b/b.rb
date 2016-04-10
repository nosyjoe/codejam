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
  acase = []
  File.open(filename) do |file| 
    test_count = file.readline
    file.readline
    file.each_line do |line|
      v = line.split("\s")
      if (v.length == 1)
        cases << acase
        acase = []
      else
        ivs = v.map {|av| av.to_i}
        acase << ivs
      end
    end
    cases << acase
    i += 1
  end
  
  #puts "warning: the number of expected test cases does not match the actual" if test_count != cases.length 
  cases
end

def unfold_attacks(tribe)
  result = {}
  
  start = tribe[0]
  nr = tribe[1]
  deltad = tribe[5]
  deltap = tribe[6]
  str = tribe[4]
  deltastr = tribe[7]
  
  (0...nr).each do |i|
    date = start + i*deltad
    result[date] = [[tribe[2]+i*deltap, tribe[3]+i*deltap, str+i*deltastr]]
  end
  
  
  result
end


def upgrade(upgrades, index, h)
  if (upgrades[index] == nil)
    upgrades[index] = h
  else
    if upgrades[index] < h
      upgrades[index] = h
    end
  end
end

def get_height(wall, index)
  if (wall[index])
    height = wall[index]
  else
    height = 0
  end
end

def do_attack(wall, date, data)
  result = 0
  upgrades = {}
  
  data.each do |at|
    success = false
    # puts "#{at}"

    s = at[0]
    e = at[1]-1
    strength = at[2]
    factor = 1
    
    if e < s
      t = e
      e = s
      s = e
      
      factor = -1
    end
    
    (s..e).each do |av|
      
      height = get_height(wall, av)

      if height < strength
        success = true
        upgrade(upgrades, av, strength)
      end
      
      if (av > s)
        height = get_height(wall, av)

        if height < strength
          success = true
          upgrade(upgrades, av+factor*0.5, strength)
        end
      end

    end
    
    if success 
      result += 1
    end
  end
  
  wall.merge!(upgrades)
  
  result
end

def process(data)
  result = []
  
  
  
  data.each do |item|
    
    attacks = {}
    wall = {}
    successes = 0
    
    day = item[0]
    nr = item[1]
    west = item[2]
    east = item[3]
    str = item[4]
    deltad = item[5]
    deltap = item[6]
    deltastr = item[7]
    
    item.each do |tribe|
      attacks.merge!(unfold_attacks(tribe)) do |k,o, n| 
        if o
          o+n
        else
          n
        end
      end
    end
  
    # puts "attacks: #{attacks}"
    puts "attacks unfolded: ##{attacks.length}"
    
    i = 0;
    attacks.keys.sort.each do |date|
      successes += do_attack(wall, date, attacks[date])
      puts "attack #{i}: successes: #{successes}"
      i += 1
      # puts "successes: #{successes}, wall #{wall}"
    end
    
    puts "successes: #{successes}"
    
    result << successes
    
    # puts ""

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

