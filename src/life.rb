# There are three methods and the "main" execution at the bottom to do.
# I have marked the locations to fill in with TODO tags.
# I recommend tackling these in order - I have numbered them in the
# order I recommend working on them.
# Remember you can use irb to test out your methods and try out syntax!

# Print the array to the screen, with x representing a living
# cell and . representing a dead cell.
# Finish the printing with a single line of asterisks, exactly
# as long as the array is wide.
# There is no need to return anything
# Example:
# ...........
# ...........
# ...........
# ...........
# ...........
# ...........
# .........x.
# ........x.x
# .......x..x
# ........xx.
# ...........
# ***********

def print_arr(arr)
  i = 0
  while i < arr.length
    j = 0
    while j < arr[0].length
      print arr[j][i]
      j += 1
    end
    puts
    i += 1
  end
  arr.each do
    print '*'
  end
  puts
  nil
end

# Should return the # of living neighbors of cell in location x, y
# in array arr (i.e., this will return a value between 0 - no living
# neighbors and 8 - every cell around this cell is living)

def num_neighbors(x, y, arr)
  answer = 0
  width = arr.length
  height = arr[0].length
  variance = [1,0,-1]
  variance.each do |one|
    variance.each do |two|
      if one == 0 && two == 0
        # do nothing
      elsif arr[(x + two) % width][(y + one) % height] == "x"
        answer += 1
      end
    end
  end
  answer
end

# Should perform one iteration of Conway's game of life, as
# described in exercise1.md
#
# arr = [['.','x','x'],['.','x','.'],['x','x','.']]

def iterate(arr)
  tmparr = Marshal.load(Marshal.dump(arr))
  i = 0
  while i < tmparr.length
    j = 0
    while j < tmparr[0].length
      if tmparr[i][j] == "."
        case num_neighbors(i, j, tmparr)
        when 3
          arr[i][j] = "x"
        end
      elsif tmparr[i][j] == "x"
        case num_neighbors(i, j, tmparr)
        when 2
          # do nothing
        when 3
          # do nothing
        else
          arr[i][j] = "."
        end
      end
      j += 1
    end
    i += 1
  end
  nil
end

# Given a pseudorandom number generator, a size, and a percentage
# of cells to be alive, make a size x size array (e.g., a 10 x 10 array
# if size = 10), and randomly assign percent % of them to be living.
# Return the newly created array to the caller.

def create_arr(prng, size, percent)
  arr = []
  (0...size).each do |x|
    arr[x] = []
    (0...size).each do |y|
      if prng.rand(101) <= percent
        arr[x][y] = "x"
      else
        arr[x][y] = "."
      end
    end
  end
  arr
end


# EXECUTION STARTS HERE

# TODO 4

raise "Enter integers for size, percentage (1..100), and number of iterations at command line" unless ARGV.count == 3
size, percent, iters = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i

# All of these can be done
# If size is not >0, inform the user and exit
# If percent is not an integer between 0 and 100, inform the user and exit
# If number of iterations is not an integer that is 0 or greater, inform the user and exit

class InputError < StandardError
  puts "bad input(s), try again"
end

unless size <= 0 || iters > 0 || (1..100).include?(percent)
  raise InputError::new
end

# Create a pseudo-random number generator to pass in to the create_array method
prng = Random.new

# Create the array and assign it a new array from the create_array method

arr = create_arr(prng, size, percent)

# Iterate for _iters_ iterations

(1..size).each do
  iterate(arr)
  print_arr(arr)
end
